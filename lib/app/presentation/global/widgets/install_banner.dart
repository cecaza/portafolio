import 'package:flutter/material.dart';

import '../colors.dart';
import '../pwa/pwa.dart';

/// Banner (solo web) que invita a descargar la app de Android (APK) o a
/// instalar Cinexa como PWA. Se muestra en móvil y escritorio web. Descartable.
class InstallBanner extends StatefulWidget {
  const InstallBanner({super.key});

  @override
  State<InstallBanner> createState() => _InstallBannerState();
}

class _InstallBannerState extends State<InstallBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return Material(
      color: CinexaColors.ink2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.android, color: CinexaColors.coral),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Cinexa luce mejor como app. Descárgala para Android.',
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: downloadApk,
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Descargar APK'),
            ),
            IconButton(
              tooltip: 'Cerrar',
              onPressed: () => setState(() => _dismissed = true),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
