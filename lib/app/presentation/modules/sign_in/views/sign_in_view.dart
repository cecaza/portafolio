import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    // Registramos el SignInController para esta pantalla (lazy). Le inyectamos
    // el repositorio leyéndolo del provider global.
    return ChangeNotifierProvider(
      create: (_) => SignInController(
        context.read<AuthenticationRepository>(),
      ),
      child: const _SignInBody(),
    );
  }
}

class _SignInBody extends StatelessWidget {
  const _SignInBody();

  Future<void> _submit(BuildContext context) async {
    final controller = context.read<SignInController>();
    final sessionController = context.read<SessionController>();
    final result = await controller.submit();

    if (!context.mounted) {
      return;
    }

    result.when(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage(failure))),
        );
      },
      (user) {
        // Guardamos el usuario en el estado GLOBAL y navegamos.
        sessionController.setUser(user);
        Navigator.pushReplacementNamed(context, Routes.home);
      },
    );
  }

  String _errorMessage(SignInFailure failure) {
    return switch (failure) {
      SignInFailure.notFound ||
      SignInFailure.unauthorized =>
        'Usuario o contraseña inválidos',
      SignInFailure.network => 'Sin conexión a internet',
      SignInFailure.notVerified => 'Tu cuenta no está verificada',
      SignInFailure.tooManyRequests =>
        'Demasiados intentos, intenta más tarde',
      SignInFailure.unknown => 'Ocurrió un error, intenta de nuevo',
    };
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignInController>();
    final state = controller.state;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.branding.logo.stackedLightTextSvg.svg(width: 200),
              const SizedBox(height: 40),
              TextField(
                enabled: !state.fetching,
                onChanged: controller.onUsernameChanged,
                decoration: const InputDecoration(
                  hintText: 'username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                enabled: !state.fetching,
                obscureText: true,
                onChanged: controller.onPasswordChanged,
                decoration: const InputDecoration(
                  hintText: 'password',
                ),
              ),
              const SizedBox(height: 20),
              if (state.fetching)
                const CircularProgressIndicator()
              else
                MaterialButton(
                  onPressed: state.isValid ? () => _submit(context) : null,
                  color: Colors.blue,
                  disabledColor: Colors.blue.withValues(alpha: 0.3),
                  child: const Text('sign in'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
