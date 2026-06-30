import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/colors.dart';
import '../../../global/controllers/theme_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Cinexa',
      applicationVersion: '1.0.1',
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

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        children: [
          const SizedBox(height: 32),
          // Encabezado simple con la identidad de la app.
          Center(
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: CinexaColors.brandGradient,
                  ),
                  child: const Icon(Icons.movie_filter,
                      color: Colors.white, size: 44),
                ),
                const SizedBox(height: 12),
                Text(
                  'Cinexa',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Elige qué ver con tu gente',
                  style: TextStyle(color: CinexaColors.muted),
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
        ],
      ),
    );
  }
}
