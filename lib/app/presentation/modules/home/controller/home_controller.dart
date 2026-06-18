import 'package:flutter/foundation.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repositories/performers_repository.dart';
import '../../../../domain/repositories/trending_repository.dart';
import 'home_state.dart';

/// Controla la pantalla Home: carga tendencias y personas, y maneja el
/// estado de forma INMUTABLE (cada cambio = copia nueva con copyWith).
class HomeController extends ChangeNotifier {
  HomeController(
    this._trendingRepository,
    this._performersRepository,
  );

  final TrendingRepository _trendingRepository;
  final PerformersRepository _performersRepository;

  HomeState _state = const HomeState();
  HomeState get state => _state;

  /// Carga inicial.
  Future<void> init() => _loadAll();

  /// Cambia la ventana de tiempo (día/semana) y recarga.
  Future<void> setTimeWindow(TimeWindow timeWindow) async {
    if (timeWindow == _state.timeWindow) return;
    _state = _state.copyWith(timeWindow: timeWindow);
    notifyListeners();
    await _loadAll();
  }

  /// Pull-to-refresh.
  Future<void> refresh() => _loadAll();

  Future<void> _loadAll() async {
    _state = _state.copyWith(
      moviesLoading: true,
      moviesFailed: false,
      performersLoading: true,
      performersFailed: false,
    );
    notifyListeners();
    await Future.wait([_loadMovies(), _loadPerformers()]);
  }

  Future<void> _loadMovies() async {
    final result = await _trendingRepository.getMovies(_state.timeWindow);
    result.when(
      (_) => _state = _state.copyWith(moviesLoading: false, moviesFailed: true),
      (movies) => _state = _state.copyWith(
        moviesLoading: false,
        moviesFailed: false,
        movies: movies,
      ),
    );
    notifyListeners();
  }

  Future<void> _loadPerformers() async {
    final result =
        await _performersRepository.getPerformers(_state.timeWindow);
    result.when(
      (_) => _state =
          _state.copyWith(performersLoading: false, performersFailed: true),
      (performers) => _state = _state.copyWith(
        performersLoading: false,
        performersFailed: false,
        performers: performers,
      ),
    );
    notifyListeners();
  }
}
