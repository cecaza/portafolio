import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/constants.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../global/colors.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../global/controllers/theme_controller.dart';
import '../../../routes/routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> _signOut(BuildContext context) async {
    final authenticationRepository = context.read<AuthenticationRepository>();
    final sessionController = context.read<SessionController>();
    final navigator = Navigator.of(context);

    await authenticationRepository.signOut();
    sessionController.clear();
    navigator.pushNamedAndRemoveUntil(Routes.signIn, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<SessionController>().user;
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          // Avatar + nombre.
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: user?.avatarPath != null
                      ? NetworkImage(
                          '${Constants.imagesBaseUrl}${user!.avatarPath}')
                      : null,
                  child: user?.avatarPath == null
                      ? const Icon(Icons.person, size: 48)
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  user?.name.isNotEmpty == true
                      ? user!.name
                      : (user?.username ?? ''),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (user != null)
                  Text(
                    '@${user.username}',
                    style: const TextStyle(color: CinexaColors.muted),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),

          // Switch de tema claro/oscuro.
          SwitchListTile(
            value: themeController.isDark,
            onChanged: (_) => context.read<ThemeController>().toggle(),
            secondary: Icon(
              themeController.isDark ? Icons.dark_mode : Icons.light_mode,
            ),
            title: const Text('Tema oscuro'),
            subtitle: Text(
              themeController.isDark ? 'Activado' : 'Desactivado',
            ),
          ),
          const Divider(),

          // Cerrar sesión.
          ListTile(
            leading: const Icon(Icons.logout, color: CinexaColors.coral),
            title: const Text('Cerrar sesión'),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
