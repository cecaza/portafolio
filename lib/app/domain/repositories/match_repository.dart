import '../enums.dart';
import '../models/match_room.dart';
import '../models/movie.dart';

/// Orquesta el "Tinder de películas": salas, swipes y matches en tiempo real.
/// La implementación usa Firebase (Auth anónima + Firestore).
abstract class MatchRepository {
  /// Garantiza una sesión anónima y devuelve el uid del dispositivo.
  Future<String> ensureSignedIn();

  /// Crea una sala nueva (el usuario actual queda como primer miembro).
  Future<MatchRoom> createRoom({
    int maxMembers = 2,
    MatchMode mode = MatchMode.unanimous,
    List<int> genreIds = const [],
  });

  /// Entra a una sala por su [code]. Devuelve null si no existe; lanza
  /// [RoomFullException] si ya está llena con otra persona.
  Future<MatchRoom?> joinRoom(String code);

  /// Escucha los cambios de una sala (miembros, géneros).
  Stream<MatchRoom> watchRoom(String roomId);

  /// Actualiza los géneros del modo "descubrir" de la sala.
  Future<void> setGenres(String roomId, List<int> genreIds);

  /// Agrega una película a la lista curada compartida de la sala.
  Future<void> addCandidate(String roomId, Movie movie);

  /// Lista curada compartida de la sala, en tiempo real.
  Stream<List<Movie>> watchCandidates(String roomId);

  /// Ids de películas que el usuario [uid] ya swipeó (para no repetirlas en el
  /// deck), en tiempo real.
  Stream<Set<int>> watchSwipedIds(String roomId, String uid);

  /// Películas que los OTROS miembros ya likearon (con datos), para priorizarlas
  /// en el mazo y acelerar los matches.
  Stream<List<Movie>> watchPartnerLikes(String roomId, String uid);

  /// Registra un swipe. Si ambos miembros dieron like a la misma película,
  /// crea el match de forma atómica. Devuelve true si este swipe generó match.
  Future<bool> swipe(String roomId, Movie movie, {required bool liked});

  /// Películas en las que ambos hicieron match, en tiempo real.
  Stream<List<Movie>> watchMatches(String roomId);
}

/// La sala ya tiene dos miembros y no admite a un tercero.
class RoomFullException implements Exception {}
