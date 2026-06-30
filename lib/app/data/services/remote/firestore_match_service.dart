import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/enums.dart';
import '../../../domain/models/match_room.dart';
import '../../../domain/models/movie.dart';
import '../../../domain/repositories/match_repository.dart';

/// Acceso a Firebase (Auth anónima + Firestore) para el "Tinder de películas".
///
/// Estructura en Firestore:
///   rooms/{roomId}                      → { code, members[], genreIds[] }
///     /candidates/{movieId}             → { movie:{...}, addedBy }
///     /swipes/{uid_movieId}             → { uid, movieId, liked, movie:{...} }
///     /matches/{movieId}                → { movie:{...}, matchedAt }
class FirestoreMatchService {
  FirestoreMatchService(this._auth, this._db);

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  // Sin caracteres ambiguos (0/O, 1/I) para que sea fácil de dictar.
  static const _codeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  CollectionReference<Map<String, dynamic>> get _rooms =>
      _db.collection('rooms');

  Future<String> ensureSignedIn() async {
    final current = _auth.currentUser;
    if (current != null) return current.uid;
    final cred = await _auth.signInAnonymously();
    return cred.user!.uid;
  }

  String _generateCode([int length = 6]) {
    final rnd = Random.secure();
    return List.generate(
      length,
      (_) => _codeAlphabet[rnd.nextInt(_codeAlphabet.length)],
    ).join();
  }

  Future<MatchRoom> createRoom({
    int maxMembers = 2,
    MatchMode mode = MatchMode.unanimous,
    List<int> genreIds = const [],
  }) async {
    final uid = await ensureSignedIn();
    final code = _generateCode();
    final doc = await _rooms.add({
      'code': code,
      'members': [uid],
      'maxMembers': maxMembers,
      'mode': mode.id,
      'genreIds': genreIds,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return MatchRoom(
      id: doc.id,
      code: code,
      members: [uid],
      maxMembers: maxMembers,
      mode: mode,
      genreIds: genreIds,
    );
  }

  Future<MatchRoom?> joinRoom(String code) async {
    final uid = await ensureSignedIn();
    final normalized = code.trim().toUpperCase();
    final query =
        await _rooms.where('code', isEqualTo: normalized).limit(1).get();
    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    final room = MatchRoom.fromMap(doc.id, doc.data());

    // Ya soy miembro: simplemente reentro.
    if (room.members.contains(uid)) return room;
    // Llena con otra persona.
    if (room.isFull) throw RoomFullException();

    await doc.reference.update({
      'members': FieldValue.arrayUnion([uid]),
    });
    return MatchRoom(
      id: room.id,
      code: room.code,
      members: [...room.members, uid],
      maxMembers: room.maxMembers,
      mode: room.mode,
      genreIds: room.genreIds,
    );
  }

  Stream<MatchRoom> watchRoom(String roomId) {
    return _rooms.doc(roomId).snapshots().map(
          (snap) => MatchRoom.fromMap(snap.id, snap.data() ?? const {}),
        );
  }

  Future<void> setGenres(String roomId, List<int> genreIds) {
    return _rooms.doc(roomId).update({'genreIds': genreIds});
  }

  Future<void> addCandidate(String roomId, Movie movie) async {
    final uid = await ensureSignedIn();
    await _rooms.doc(roomId).collection('candidates').doc('${movie.id}').set({
      'movie': movie.toJson(),
      'addedBy': uid,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Movie>> watchCandidates(String roomId) {
    return _rooms.doc(roomId).collection('candidates').snapshots().map(
          (snap) => snap.docs
              .map((d) => Movie.fromJson(d.data()['movie'] as Map<String, dynamic>))
              .toList(),
        );
  }

  Stream<Set<int>> watchSwipedIds(String roomId, String uid) {
    return _rooms
        .doc(roomId)
        .collection('swipes')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => d.data()['movieId'] as int).toSet());
  }

  Future<bool> swipe(String roomId, Movie movie, {required bool liked}) async {
    final uid = await ensureSignedIn();
    final roomRef = _rooms.doc(roomId);

    // Estado actual de la sala (miembros, modo) para evaluar el match.
    final roomSnap = await roomRef.get();
    final room = MatchRoom.fromMap(roomSnap.id, roomSnap.data() ?? const {});
    final others = room.others(uid);

    final mySwipeRef =
        roomRef.collection('swipes').doc('${uid}_${movie.id}');
    final matchRef = roomRef.collection('matches').doc('${movie.id}');

    return _db.runTransaction<bool>((txn) async {
      // Regla de Firestore: todas las lecturas antes de las escrituras.
      // Solo tiene sentido evaluar match si yo di like.
      var likesFromOthers = 0;
      var alreadyMatched = false;
      if (liked) {
        for (final other in others) {
          final s = await txn
              .get(roomRef.collection('swipes').doc('${other}_${movie.id}'));
          if (s.exists && s.data()?['liked'] == true) likesFromOthers++;
        }
        final existing = await txn.get(matchRef);
        alreadyMatched = existing.exists;
      }

      txn.set(mySwipeRef, {
        'uid': uid,
        'movieId': movie.id,
        'liked': liked,
        'movie': movie.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!liked) return false;

      final totalLikes = likesFromOthers + 1; // incluyo mi like
      final totalMembers = room.members.length;
      final isMatch = totalMembers >= 2 &&
          switch (room.mode) {
            MatchMode.unanimous => totalLikes == totalMembers,
            MatchMode.majority => totalLikes * 2 > totalMembers,
          };

      // Crear el match solo la primera vez (evita re-celebrar).
      if (isMatch && !alreadyMatched) {
        txn.set(matchRef, {
          'movie': movie.toJson(),
          'matchedAt': FieldValue.serverTimestamp(),
        });
        return true;
      }
      return false;
    });
  }

  Stream<List<Movie>> watchMatches(String roomId) {
    return _rooms
        .doc(roomId)
        .collection('matches')
        .orderBy('matchedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Movie.fromJson(d.data()['movie'] as Map<String, dynamic>))
            .toList());
  }
}
