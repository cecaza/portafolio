import 'package:flutter/material.dart';

/// Widget REUTILIZABLE para mostrar cuando una petición falla.
/// Evita repetir el mismo bloque de error en cada pantalla.
class RequestFailed extends StatelessWidget {
  const RequestFailed({
    super.key,
    this.onRetry,
    this.message = 'No se pudo cargar la información',
  });

  /// Callback al pulsar "Reintentar". Si es `null`, no se muestra el botón.
  final VoidCallback? onRetry;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ],
      ),
    );
  }
}
