import '../../domain/enums.dart';
import '../../domain/models/match_room.dart';
import '../../domain/models/movie.dart';
import '../../domain/repositories/match_repository.dart';
import '../services/remote/firestore_match_service.dart';

class MatchRepositoryImpl implements MatchRepository {
  MatchRepositoryImpl(this._service);

  final FirestoreMatchService _service;

  @override
  Future<String> ensureSignedIn() => _service.ensureSignedIn();

  @override
  Future<MatchRoom> createRoom({
    int maxMembers = 2,
    MatchMode mode = MatchMode.unanimous,
    List<int> genreIds = const [],
  }) =>
      _service.createRoom(
        maxMembers: maxMembers,
        mode: mode,
        genreIds: genreIds,
      );

  @override
  Future<MatchRoom?> joinRoom(String code) => _service.joinRoom(code);

  @override
  Stream<MatchRoom> watchRoom(String roomId) => _service.watchRoom(roomId);

  @override
  Future<void> setGenres(String roomId, List<int> genreIds) =>
      _service.setGenres(roomId, genreIds);

  @override
  Future<void> addCandidate(String roomId, Movie movie) =>
      _service.addCandidate(roomId, movie);

  @override
  Stream<List<Movie>> watchCandidates(String roomId) =>
      _service.watchCandidates(roomId);

  @override
  Stream<Set<int>> watchSwipedIds(String roomId, String uid) =>
      _service.watchSwipedIds(roomId, uid);

  @override
  Future<bool> swipe(String roomId, Movie movie, {required bool liked}) =>
      _service.swipe(roomId, movie, liked: liked);

  @override
  Stream<List<Movie>> watchMatches(String roomId) =>
      _service.watchMatches(roomId);
}
