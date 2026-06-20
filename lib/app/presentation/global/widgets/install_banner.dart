import 'package:flutter/material.dart';

import '../colors.dart';
import '../pwa/pwa.dart';

/// Banner que se muestra en navegadores de escritorio invitando a instalar
/// Cinexa como app (PWA) o a usarla en el celular. Es descartable.
class InstallBanner extends StatefulWidget {
  const InstallBanner({super.key});

  @override
  State<InstallBanner> createState() => _InstallBannerState();
}

class _InstallBannerState extends State<InstallBanner> {
  bool _dismissed = false;

  void _install() {
    if (canInstallPwa()) {
      installPwa();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Para instalar, usa el ícono de instalación (⊕) en la barra de '
            'direcciones de tu navegador, o ábrela en tu celular.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    return Material(
      color: CinexaColors.ink2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.phone_iphone, color: CinexaColors.coral),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Cinexa luce mejor en el celular. Instálala como app o ábrela '
                'en tu móvil.',
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: _install,
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Instalar'),
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
