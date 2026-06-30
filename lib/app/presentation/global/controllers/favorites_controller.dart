import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/movie.dart';

const _favoritesKey = 'localFavorites';

/// Favoritos LOCALES: se guardan en el dispositivo con shared_preferences,
/// sin necesidad de cuenta de TMDB. Cualquiera puede usarlos.
class FavoritesController extends ChangeNotifier {
  FavoritesController(this._prefs) {
    _load();
  }

  final SharedPreferences _prefs;
  final List<Movie> _favorites = [];

  List<Movie> get favorites => List.unmodifiable(_favorites);

  void _load() {
    final raw = _prefs.getString(_favoritesKey);
    if (raw == null) return;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      _favorites
        ..clear()
        ..addAll(
          list.map((e) => Movie.fromJson(e as Map<String, dynamic>)),
        );
    } catch (_) {
      // Si el formato guardado es inválido, empezamos vacío.
    }
  }

  bool isFavorite(int id) => _favorites.any((m) => m.id == id);

  /// Agrega o quita la película de favoritos. Devuelve true si quedó marcada.
  Future<bool> toggle(Movie movie) async {
    final nowFavorite = !isFavorite(movie.id);
    if (nowFavorite) {
      _favorites.insert(0, movie);
    } else {
      _favorites.removeWhere((m) => m.id == movie.id);
    }
    notifyListeners();
    await _persist();
    return nowFavorite;
  }

  Future<void> _persist() async {
    final raw = jsonEncode(_favorites.map((m) => m.toJson()).toList());
    await _prefs.setString(_favoritesKey, raw);
  }
}
