import 'package:flutter/material.dart';

import '../../../repositories.dart';
import '../colors.dart';

/// Envuelve toda la app y muestra un banner inferior cuando se pierde la
/// conexión a internet, escuchando el stream de [ConnectivityRepository].
class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({super.key, required this.child});

  final Widget child;

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  late final Stream<bool> _stream;

  @override
  void initState() {
    super.initState();
    _stream = Repositories.connectivity.onInternetChanged;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _stream,
      builder: (context, snapshot) {
        final offline = snapshot.data == false;
        return Stack(
          children: [
            widget.child,
            if (offline)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Material(
                  color: Colors.transparent,
                  child: SafeArea(
                    child: Container(
                      width: double.infinity,
                      color: CinexaColors.coral,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Sin conexión a internet',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
