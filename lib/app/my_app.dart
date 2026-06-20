import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/global/controllers/theme_controller.dart';
import 'presentation/global/theme/cinexa_theme.dart';
import 'presentation/global/widgets/connectivity_banner.dart';
import 'presentation/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        title: 'Cinexa',
        debugShowCheckedModeBanner: false,
        theme: CinexaTheme.light(),
        darkTheme: CinexaTheme.dark(),
        themeMode: themeController.mode,
        // Permite arrastrar los carruseles con mouse/trackpad en web y desktop.
        scrollBehavior: const _AppScrollBehavior(),
        routerConfig: appRouter,
        builder: (context, child) => ConnectivityBanner(
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}

/// Habilita el arrastre de scrollables con mouse y trackpad (no solo táctil),
/// necesario para que los carruseles horizontales naveguen en web/escritorio.
class _AppScrollBehavior extends MaterialScrollBehavior {
  const _AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
