import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/movie.dart';
import '../../../../domain/models/movie_detail.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../global/controllers/favorites_controller.dart';
import '../../../global/widgets/cinexa_loader.dart';
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
    _future ??= Repositories.movie.getById(widget.movieId);
  }

  void _reload() {
    setState(() {
      _future = Repositories.movie.getById(widget.movieId);
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
  Future<void> _toggleFavorite() async {
    final m = widget.movie;
    final added = await context.read<FavoritesController>().toggle(
          Movie(
            id: m.id,
            title: m.title,
            overview: m.overview,
            posterPath: m.posterPath,
            backdropPath: m.backdropPath,
            voteAverage: m.voteAverage,
            releaseDate: m.releaseDate,
          ),
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(added ? 'Agregada a favoritos' : 'Quitada de favoritos'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final isFav = context.watch<FavoritesController>().isFavorite(movie.id);
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
            onTap: () => context.pop(),
          ),
          actions: [
            _CircleButton(
              icon: isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? CinexaColors.coral : Colors.white,
              onTap: _toggleFavorite,
            ),
            const SizedBox(width: 8),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                if (backdrop != null)
                  Image.network(
                    '${Constants.imagesBaseUrl}$backdrop',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _backdropPlaceholder(),
                  )
                else
                  _backdropPlaceholder(),
                // Degradado para legibilidad.
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
                // Calificación, en la esquina inferior izquierda.
                Positioned(
                  left: 16,
                  bottom: 12,
                  child: _RatingCircle(value: movie.voteAverage),
                ),
                // Año + duración, en la esquina inferior derecha.
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: _InfoOverlay(year: year, runtime: movie.runtime),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                const SizedBox(height: 12),
                _MoneyRow(budget: movie.budget, revenue: movie.revenue),
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

  /// Calificación de 0 a 10.
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CinexaColors.deep.withValues(alpha: 0.85),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(
              value: value / 10,
              strokeWidth: 4,
              backgroundColor: CinexaColors.faint,
              valueColor: const AlwaysStoppedAnimation(CinexaColors.coral),
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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

/// Pastilla con año + duración, sobre el backdrop.
class _InfoOverlay extends StatelessWidget {
  const _InfoOverlay({required this.year, required this.runtime});

  final String year;
  final int runtime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (year.isNotEmpty) ...[
            const Icon(Icons.calendar_today, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Text(year,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
          if (year.isNotEmpty && runtime > 0) const SizedBox(width: 12),
          if (runtime > 0) ...[
            const Icon(Icons.schedule, size: 15, color: Colors.white),
            const SizedBox(width: 4),
            Text('$runtime min',
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ],
      ),
    );
  }
}

/// Fila con presupuesto y recaudación.
class _MoneyRow extends StatelessWidget {
  const _MoneyRow({required this.budget, required this.revenue});

  final int budget;
  final int revenue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MoneyItem(
            icon: Icons.payments_outlined,
            label: 'Presupuesto',
            value: _money(budget),
          ),
        ),
        Expanded(
          child: _MoneyItem(
            icon: Icons.attach_money,
            label: 'Recaudó',
            value: _money(revenue),
          ),
        ),
      ],
    );
  }
}

class _MoneyItem extends StatelessWidget {
  const _MoneyItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: CinexaColors.coral),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                    const TextStyle(fontSize: 11, color: CinexaColors.muted)),
            Text(value,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}

/// Formatea un entero como dinero con separadores de miles: 1000000 -> $1,000,000
String _money(int value) {
  if (value <= 0) return 'N/D';
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }
  return '\$$buffer';
}
