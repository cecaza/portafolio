import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../config/constants.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../global/controllers/theme_controller.dart';
import '../../../routes/routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Cinexa',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2026 Cinexa',
      children: const [
        SizedBox(height: 16),
        Text(
          'Datos y pósters de películas proporcionados por TMDB.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        // Atribución requerida por la política de uso de la API de TMDB.
        Text(
          'This product uses the TMDB API but is not endorsed or certified '
          'by TMDB.',
          style: TextStyle(color: CinexaColors.muted),
        ),
      ],
    );
  }

  Future<void> _signOut(BuildContext context) async {
    final sessionController = context.read<SessionController>();

    await Repositories.authentication.signOut();
    sessionController.clear();
    if (context.mounted) {
      context.go(Routes.home);
    }
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

          // Acerca de + atribución a TMDB (requerida por su API).
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            subtitle: const Text(
              'Créditos y datos de TMDB',
              style: TextStyle(color: CinexaColors.muted),
            ),
            onTap: () => _showAbout(context),
          ),
          const Divider(),

          // Iniciar / cerrar sesión según el estado.
          if (user == null)
            ListTile(
              leading: const Icon(Icons.login, color: CinexaColors.coral),
              title: const Text('Iniciar sesión'),
              subtitle: const Text(
                'Opcional: para guardar favoritos de tu cuenta TMDB',
                style: TextStyle(color: CinexaColors.muted),
              ),
              onTap: () => context.go(Routes.signIn),
            )
          else
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
