import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/models/movie.dart';
import '../../../global/colors.dart';
import '../../../global/controllers/favorites_controller.dart';
import '../../../routes/routes.dart';

/// Favoritos LOCALES del dispositivo (sin cuenta). Se llenan marcando ♥ en el
/// detalle de cada película.
class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesController>().favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: favorites.isEmpty
          ? _EmptyFavorites()
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 0.55,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (_, i) => _FavoritePoster(movie: favorites[i]),
            ),
    );
  }
}

class _FavoritePoster extends StatelessWidget {
  const _FavoritePoster({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    return GestureDetector(
      onTap: () => context.push('${Routes.movie}/${movie.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: posterPath != null
            ? Image.network(
                '${Constants.imagesBaseUrl}$posterPath',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _poster(),
              )
            : _poster(),
      ),
    );
  }

  Widget _poster() {
    return Assets.branding.placeholders.posterPlaceholderPng
        .image(fit: BoxFit.cover);
  }
}

class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 80),
        Assets.branding.placeholders.emptyStatePng.image(width: 160),
        const SizedBox(height: 16),
        const Text(
          'Aún no tienes favoritos',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        const Text(
          'Marca películas con ♥ para verlas aquí',
          textAlign: TextAlign.center,
          style: TextStyle(color: CinexaColors.muted),
        ),
      ],
    );
  }
}
