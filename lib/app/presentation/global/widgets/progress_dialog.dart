import 'package:flutter/material.dart';

import 'cinexa_loader.dart';

/// Diálogo modal de carga reutilizable. Bloquea la pantalla mientras se
/// realiza una operación (p. ej. marcar favorito).
class ProgressDialog {
  ProgressDialog._();

  /// Muestra el diálogo. No se puede cerrar tocando fuera.
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) => const PopScope(
        canPop: false,
        child: Center(child: CinexaLoader(size: 80)),
      ),
    );
  }

  /// Cierra el diálogo.
  static void close(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
