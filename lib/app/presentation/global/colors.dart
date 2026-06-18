import 'package:flutter/material.dart';

/// Paleta de marca de Cinexa.
class CinexaColors {
  CinexaColors._();

  static const coral = Color(0xFFFF5E62); // Primary / accents
  static const orange = Color(0xFFFF9966); // Gradient end, highlights
  static const ink = Color(0xFF1A1426); // Background (dark)
  static const ink2 = Color(0xFF241B33); // Cards / surfaces
  static const deep = Color(0xFF0F0B17); // Darkest background variant
  static const muted = Color(0xFF8A7F99); // Secondary text
  static const faint = Color(0xFF3A2F4D); // Disabled / placeholder shapes

  /// Degradado característico de la marca (coral → naranja).
  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [coral, orange],
  );
}
