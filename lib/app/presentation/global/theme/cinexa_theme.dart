import 'package:flutter/material.dart';

import '../colors.dart';

/// Temas claro y oscuro de Cinexa, construidos a partir de la paleta de marca.
class CinexaTheme {
  CinexaTheme._();

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CinexaColors.ink,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CinexaColors.coral,
        brightness: Brightness.dark,
        primary: CinexaColors.coral,
        secondary: CinexaColors.orange,
        surface: CinexaColors.ink2,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CinexaColors.deep,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CinexaColors.coral,
        brightness: Brightness.light,
        primary: CinexaColors.coral,
        secondary: CinexaColors.orange,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CinexaColors.coral,
        foregroundColor: Colors.white,
      ),
    );
  }
}
