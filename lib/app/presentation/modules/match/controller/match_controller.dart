import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/models/discover_filter.dart';
import '../../../../domain/models/match_room.dart';
import '../../../../domain/models/movie.dart';
import '../../../../domain/repositories/match_repository.dart';
import '../../../../repositories.dart';

/// Estado del módulo "Tinder de películas".
///
/// Maneja la sesión anónima, la sala actual, el mazo de cartas a swipear
/// (alimentado por la lista curada o por descubrimiento por género) y el
/// último match para celebrarlo en la UI.
class MatchController extends ChangeNotifier {
  String? uid;
  MatchRoom? room;

  /// Mensaje de error puntual (al crear/unir sala).
  String? error;

  /// Película que acaba de hacer match (para mostrar el "¡Es match!").
  Movie? lastMatch;

  bool busy = false;

  /// Fuente de películas conocidas (curadas o descubiertas).
  final List<Movie> _buffer = [];

  /// Películas que mi pareja ya likeó (se muestran primero en mi mazo).
  final List<Movie> _partnerLikes = [];

  /// Ids ya swipeados por mí (no vuelven a salir en el mazo).
  final Set<int> _swiped = {};

  bool loadingDeck = false;
  int _discoverPage = 0;
  int _discoverTotalPages = 1;

  StreamSubscription<MatchRoom>? _roomSub;
  StreamSubscription<List<Movie>>? _candidatesSub;
  StreamSubscription<Set<int>>? _swipedSub;
  StreamSubscription<List<Movie>>? _partnerLikesSub;

  /// Modo descubrimiento activo cuando hay géneros elegidos.
  bool get inDiscoverMode => room?.genreIds.isNotEmpty ?? false;

  /// Cartas pendientes, sin repetir y sin las que ya swipeé. Las que mi pareja
  /// ya likeó van PRIMERO (si yo les doy like, hay match al instante).
  List<Movie> get deck {
    final seen = <int>{};
    final result = <Movie>[];
    for (final m in _partnerLikes) {
      if (!_swiped.contains(m.id) && seen.add(m.id)) result.add(m);
    }
    for (final m in _buffer) {
      if (!_swiped.contains(m.id) && seen.add(m.id)) result.add(m);
    }
    return result;
  }

  /// Ids que mi pareja ya likeó (para marcarlos "🔥" en el mazo).
  Set<int> get partnerLikedIds => _partnerLikes.map((m) => m.id).toSet();

  /// Cuántas cartas quedan del pool propio (sin contar las de la pareja), para
  /// decidir si recargar más sugerencias.
  int get _poolRemaining =>
      _buffer.where((m) => !_swiped.contains(m.id)).length;

  Future<void> init() async {
    uid = await Repositories.match.ensureSignedIn();
    notifyListeners();
  }

  Future<void> createRoom({
    int maxMembers = 2,
    MatchMode mode = MatchMode.unanimous,
    List<int> genreIds = const [],
  }) async {
    await _guard(() async {
      final r = await Repositories.match.createRoom(
        maxMembers: maxMembers,
        mode: mode,
        genreIds: genreIds,
      );
      _bindRoom(r);
    });
  }

  /// Devuelve true si entró correctamente.
  Future<bool> joinRoom(String code) async {
    if (code.trim().isEmpty) {
      error = 'Escribe un código';
      notifyListeners();
      return false;
    }
    var ok = false;
    await _guard(() async {
      try {
        final r = await Repositories.match.joinRoom(code);
        if (r == null) {
          error = 'No existe una sala con ese código';
          return;
        }
        _bindRoom(r);
        ok = true;
      } on RoomFullException {
        error = 'Esa sala ya está llena';
      }
    });
    return ok;
  }

  Future<void> _guard(Future<void> Function() action) async {
    busy = true;
    error = null;
    notifyListeners();
    try {
      await action();
    } catch (e) {
      error = 'Algo salió mal. Revisa tu conexión e inténtalo de nuevo.';
    } finally {
      busy = false;
      notifyListeners();
    }
  }

  void _bindRoom(MatchRoom r) {
    room = r;
    _buffer.clear();
    _partnerLikes.clear();
    _swiped.clear();
    _discoverPage = 0;
    _discoverTotalPages = 1;

    _roomSub?.cancel();
    _roomSub = Repositories.match.watchRoom(r.id).listen(_onRoomChanged);

    _swipedSub?.cancel();
    _swipedSub =
        Repositories.match.watchSwipedIds(r.id, uid!).listen((ids) {
      _swiped
        ..clear()
        ..addAll(ids);
      _maybeRefillDiscover();
      notifyListeners();
    });

    _partnerLikesSub?.cancel();
    _partnerLikesSub =
        Repositories.match.watchPartnerLikes(r.id, uid!).listen((likes) {
      _partnerLikes
        ..clear()
        ..addAll(likes);
      notifyListeners();
    });

    _startDeckSource();
  }

  void _onRoomChanged(MatchRoom updated) {
    final modeChanged = inDiscoverMode != updated.genreIds.isNotEmpty ||
        !listEquals(room?.genreIds, updated.genreIds);
    room = updated;
    if (modeChanged) {
      _buffer.clear();
      _discoverPage = 0;
      _discoverTotalPages = 1;
      _startDeckSource();
    }
    notifyListeners();
  }

  void _startDeckSource() {
    _candidatesSub?.cancel();
    if (inDiscoverMode) {
      _loadNextDiscoverPage();
    } else {
      _candidatesSub =
          Repositories.match.watchCandidates(room!.id).listen((movies) {
        _buffer
          ..clear()
          ..addAll(movies);
        notifyListeners();
      });
    }
  }

  /// Cambia los géneros del modo descubrir (vacío = volver a lista curada).
  Future<void> setGenres(List<int> genreIds) async {
    if (room == null) return;
    await Repositories.match.setGenres(room!.id, genreIds);
  }

  Future<void> addCandidate(Movie movie) async {
    if (room == null) return;
    await Repositories.match.addCandidate(room!.id, movie);
  }

  void _maybeRefillDiscover() {
    if (inDiscoverMode && _poolRemaining < 5) {
      _loadNextDiscoverPage();
    }
  }

  Future<void> _loadNextDiscoverPage() async {
    if (loadingDeck) return;
    if (_discoverPage >= _discoverTotalPages) return;
    loadingDeck = true;
    notifyListeners();

    final genres = MovieGenre.values
        .where((g) => room!.genreIds.contains(g.id))
        .toSet();
    final result = await Repositories.discover.getMovies(
      DiscoverFilter(genres: genres),
      page: _discoverPage + 1,
    );
    result.when(
      (_) {},
      (page) {
        _discoverPage = page.page;
        _discoverTotalPages = page.totalPages;
        _buffer.addAll(page.movies);
      },
    );
    loadingDeck = false;
    notifyListeners();
  }

  /// Registra el swipe de la carta superior. Quita la carta de inmediato
  /// (optimista) y, si genera match, lo expone en [lastMatch].
  Future<void> swipe(Movie movie, {required bool liked}) async {
    if (room == null) return;
    _swiped.add(movie.id); // optimista: no esperar al stream
    _maybeRefillDiscover();
    notifyListeners();

    final matched =
        await Repositories.match.swipe(room!.id, movie, liked: liked);
    if (matched) {
      lastMatch = movie;
      notifyListeners();
    }
  }

  void clearLastMatch() {
    lastMatch = null;
    notifyListeners();
  }

  /// Sale de la sala actual (vuelve al lobby).
  void leaveRoom() {
    _roomSub?.cancel();
    _candidatesSub?.cancel();
    _swipedSub?.cancel();
    _partnerLikesSub?.cancel();
    room = null;
    _buffer.clear();
    _partnerLikes.clear();
    _swiped.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _roomSub?.cancel();
    _candidatesSub?.cancel();
    _swipedSub?.cancel();
    _partnerLikesSub?.cancel();
    super.dispose();
  }
}
