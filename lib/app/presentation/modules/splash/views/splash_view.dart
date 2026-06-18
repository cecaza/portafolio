import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
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
    final connectivityRepository = context.read<ConnectivityRepository>();
    final authenticationRepository = context.read<AuthenticationRepository>();
    final sessionController = context.read<SessionController>();

    final hasInternet = await connectivityRepository.hasInternet;
    if (!mounted) return;

    if (!hasInternet) {
      _goTo(Routes.offline);
      return;
    }

    final user = await authenticationRepository.getUserData();
    if (!mounted) return;

    if (user != null) {
      sessionController.setUser(user);
      _goTo(Routes.home);
    } else {
      _goTo(Routes.signIn);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
