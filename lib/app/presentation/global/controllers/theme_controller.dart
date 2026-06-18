import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'themeMode';

/// Maneja el tema (claro/oscuro) de la app y lo PERSISTE con
/// shared_preferences, para recordarlo entre sesiones.
class ThemeController extends ChangeNotifier {
  ThemeController(this._prefs) {
    final saved = _prefs.getString(_themeKey);
    _mode = switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.dark, // por defecto, oscuro (la identidad de Cinexa)
    };
  }

  final SharedPreferences _prefs;

  ThemeMode _mode = ThemeMode.dark;
  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  /// Alterna entre claro y oscuro y guarda la preferencia.
  Future<void> toggle() async {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    await _prefs.setString(_themeKey, isDark ? 'dark' : 'light');
  }
}
