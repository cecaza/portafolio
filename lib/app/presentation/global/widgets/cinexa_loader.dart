import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

/// Loader de marca de Cinexa (usa el gif animado del set de assets).
class CinexaLoader extends StatelessWidget {
  const CinexaLoader({super.key, this.size = 72});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.branding.loaders.loaderOrbitGif.image(
        width: size,
        height: size,
      ),
    );
  }
}
