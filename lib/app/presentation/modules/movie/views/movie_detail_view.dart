import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/movie_detail.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../../../domain/repositories/movie_repository.dart';
import '../../../global/colors.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../../../global/widgets/progress_dialog.dart';
import '../../../global/widgets/request_failed.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  Future<Either<HttpFailureType, MovieDetail>>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future ??= context.read<MovieRepository>().getById(widget.movieId);
  }

  void _reload() {
    setState(() {
      _future = context.read<MovieRepository>().getById(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Either<HttpFailureType, MovieDetail>>(
        future: _future,
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CinexaLoader();
          }
          final result = snapshot.data;
          if (result == null) {
            return RequestFailed(onRetry: _reload);
          }
          return result.when(
            (_) => RequestFailed(
              message: 'No se pudo cargar la película',
              onRetry: _reload,
            ),
            (movie) => _MovieDetailBody(movie: movie),
          );
        },
      ),
    );
  }
}

class _MovieDetailBody extends StatefulWidget {
  const _MovieDetailBody({required this.movie});

  final MovieDetail movie;

  @override
  State<_MovieDetailBody> createState() => _MovieDetailBodyState();
}

class _MovieDetailBodyState extends State<_MovieDetailBody> {
  late bool _isFavorite = widget.movie.isFavorite;

  Future<void> _toggleFavorite() async {
    final accountId = context.read<SessionController>().user?.id;
    if (accountId == null) return;

    final accountRepository = context.read<AccountRepository>();
    final newValue = !_isFavorite;

    ProgressDialog.show(context);
    final result = await accountRepository.markAsFavorite(
      accountId,
      widget.movie.id,
      newValue,
    );
    if (!mounted) return;
    ProgressDialog.close(context);

    result.when(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo actualizar el favorito')),
        );
      },
      (_) {
        setState(() => _isFavorite = newValue);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              newValue ? 'Agregada a favoritos' : 'Quitada de favoritos',
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final backdrop = movie.backdropPath;
    final year = (movie.releaseDate ?? '').length >= 4
        ? movie.releaseDate!.substring(0, 4)
        : '';

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 260,
          pinned: true,
          backgroundColor: CinexaColors.deep,
          leading: _CircleButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
          actions: [
            _CircleButton(
              icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? CinexaColors.coral : Colors.white,
              onTap: _toggleFavorite,
            ),
            const SizedBox(width: 8),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: backdrop != null
                ? Image.network(
                    '${Constants.imagesBaseUrl}$backdrop',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _backdropPlaceholder(),
                  )
                : _backdropPlaceholder(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (movie.tagline.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              movie.tagline,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: CinexaColors.muted,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _RatingCircle(value: movie.voteAverage),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: movie.genres
                      .map(
                        (g) => Chip(
                          label: Text(g.name),
                          visualDensity: VisualDensity.compact,
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (year.isNotEmpty) ...[
                      const Icon(Icons.calendar_today, size: 15),
                      const SizedBox(width: 4),
                      Text(year),
                      const SizedBox(width: 16),
                    ],
                    if (movie.runtime > 0) ...[
                      const Icon(Icons.schedule, size: 16),
                      const SizedBox(width: 4),
                      Text('${movie.runtime} min'),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  movie.overview.isEmpty
                      ? 'Sin descripción disponible.'
                      : movie.overview,
                  style: const TextStyle(height: 1.4),
                ),
                if (movie.cast.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Reparto',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.cast.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) => _CastAvatar(cast: movie.cast[i]),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _backdropPlaceholder() {
    return Assets.branding.placeholders.backdropPlaceholderPng
        .image(fit: BoxFit.cover);
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.color = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.black45,
        child: IconButton(
          icon: Icon(icon, color: color, size: 20),
          onPressed: onTap,
        ),
      ),
    );
  }
}

class _RatingCircle extends StatelessWidget {
  const _RatingCircle({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value / 10,
            strokeWidth: 4,
            backgroundColor: CinexaColors.faint,
            valueColor: const AlwaysStoppedAnimation(CinexaColors.coral),
          ),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _CastAvatar extends StatelessWidget {
  const _CastAvatar({required this.cast});

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    final profile = cast.profilePath;
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: profile != null
                ? NetworkImage('${Constants.imagesBaseUrl}$profile')
                : Assets.branding.placeholders.avatarPlaceholderPng.provider(),
          ),
          const SizedBox(height: 6),
          Text(
            cast.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            cast.character,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: CinexaColors.muted),
          ),
        ],
      ),
    );
  }
}
