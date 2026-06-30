import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants.dart';
import '../../../../domain/models/movie.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../routes/routes.dart';

/// Lista de películas en las que ambos hicieron match dentro de una sala.
class MatchesView extends StatelessWidget {
  const MatchesView({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sus matches')),
      body: StreamBuilder<List<Movie>>(
        stream: Repositories.match.watchMatches(roomId),
        builder: (_, snapshot) {
          final movies = snapshot.data ?? const [];
          if (movies.isEmpty) {
            return _Empty();
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 0.55,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: movies.length,
            itemBuilder: (_, i) => _MatchPoster(movie: movies[i]),
          );
        },
      ),
    );
  }
}

class _MatchPoster extends StatelessWidget {
  const _MatchPoster({required this.movie});

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

class _Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 80),
        Assets.branding.placeholders.emptyStatePng.image(width: 160),
        const SizedBox(height: 16),
        const Text(
          'Aún no hay matches',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        const Text(
          'Sigan swipeando: cuando a los dos les guste\nla misma, aparece aquí',
          textAlign: TextAlign.center,
          style: TextStyle(color: CinexaColors.muted),
        ),
      ],
    );
  }
}
