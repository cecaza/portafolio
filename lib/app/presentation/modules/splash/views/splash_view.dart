import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Capturamos las dependencias ANTES de los await (buena práctica con
    // BuildContext en código asíncrono).
    final sessionController = context.read<SessionController>();

    final hasInternet = await Repositories.connectivity.hasInternet;
    if (!mounted) return;

    if (!hasInternet) {
      _goTo(Routes.offline);
      return;
    }

    final user = await Repositories.authentication.getUserData();
    if (!mounted) return;

    // El login de TMDB es OPCIONAL: si hay sesión guardada la usamos, pero si
    // no, entramos igual a la app (catálogo + match funcionan sin cuenta). El
    // inicio de sesión queda disponible desde Perfil para quien quiera usar
    // favoritos y demás funciones de su cuenta TMDB.
    if (user != null) {
      sessionController.setUser(user);
    }
    _goTo(Routes.home);
  }

  void _goTo(String routeName) {
    context.go(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El splash siempre va en oscuro (identidad de Cinexa), sin importar
      // el tema del sistema.
      backgroundColor: CinexaColors.ink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.branding.splash.splashLogoSvg.svg(width: 180),
            const SizedBox(height: 24),
            const CinexaLoader(size: 64),
          ],
        ),
      ),
    );
  }
}
