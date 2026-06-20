import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/movie.dart';
import '../../../../domain/models/performer.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../../../global/widgets/request_failed.dart';
import '../../../routes/routes.dart';
import '../controller/home_controller.dart';
import '../controller/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(
        Repositories.trending,
        Repositories.performers,
        Repositories.categories,
      )..init(),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    final state = controller.state;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Assets.branding.logo.primaryLightTextSvg.svg(height: 28),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TRENDING',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                  ),
                  DropdownButton<TimeWindow>(
                    value: state.timeWindow,
                    underline: const SizedBox.shrink(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setTimeWindow(value);
                      }
                    },
                    items: TimeWindow.values
                        .map(
                          (tw) => DropdownMenuItem(
                            value: tw,
                            child: Text(tw.label),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 210,
              child: _buildMovies(context, state, controller),
            ),
            ..._buildSections(context, state, controller),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Personas populares',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 380,
              child: _buildPerformers(context, state, controller),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMovies(
    BuildContext context,
    HomeState state,
    HomeController controller,
  ) {
    if (state.moviesLoading) {
      return const CinexaLoader();
    }
    if (state.moviesFailed) {
      return RequestFailed(
        message: 'No se pudieron cargar las películas',
        onRetry: controller.refresh,
      );
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: state.movies.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, i) => _MovieCard(movie: state.movies[i]),
    );
  }

  Widget _buildPerformers(
    BuildContext context,
    HomeState state,
    HomeController controller,
  ) {
    if (state.performersLoading) {
      return const CinexaLoader();
    }
    if (state.performersFailed) {
      return RequestFailed(
        message: 'No se pudieron cargar las personas',
        onRetry: controller.refresh,
      );
    }
    return _PerformersCarousel(performers: state.performers);
  }

  /// Secciones por categoría (En cartelera, Mejor valoradas, Próximamente).
  /// Cada una es un carrusel horizontal con enlace "Ver todo" al catálogo
  /// paginado con scroll infinito.
  List<Widget> _buildSections(
    BuildContext context,
    HomeState state,
    HomeController controller,
  ) {
    if (state.sectionsLoading) {
      return const [
        SizedBox(height: 210, child: CinexaLoader()),
      ];
    }
    if (state.sections.isEmpty) {
      return const [];
    }
    return [
      for (final entry in state.sections.entries)
        if (entry.value.isNotEmpty) ...[
          _SectionHeader(category: entry.key),
          SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: entry.value.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => _MovieCard(movie: entry.value[i]),
            ),
          ),
        ],
    ];
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.category});

  final MovieCategory category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextButton(
            onPressed: () =>
                context.push('${Routes.category}/${category.path}'),
            child: const Text('Ver todo'),
          ),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    return GestureDetector(
      onTap: () => context.push('${Routes.movie}/${movie.id}'),
      child: SizedBox(
        width: 130,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: posterPath != null
                  ? Image.network(
                      '${Constants.imagesBaseUrl}$posterPath',
                      height: 200,
                      width: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _poster(),
                    )
                  : _poster(),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _poster() {
    return Assets.branding.placeholders.posterPlaceholderPng.image(
      height: 200,
      width: 130,
      fit: BoxFit.cover,
    );
  }
}

class _PerformersCarousel extends StatefulWidget {
  const _PerformersCarousel({required this.performers});

  final List<Performer> performers;

  @override
  State<_PerformersCarousel> createState() => _PerformersCarouselState();
}

class _PerformersCarouselState extends State<_PerformersCarousel> {
  PageController? _controller;
  double _fraction = 0;
  int _current = 0;

  /// Recrea el controlador solo si cambia la fracción (cruce de breakpoint).
  PageController _controllerFor(double fraction) {
    if (_controller == null || _fraction != fraction) {
      _fraction = fraction;
      _controller?.dispose();
      _controller = PageController(viewportFraction: fraction);
    }
    return _controller!;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dotsCount =
        widget.performers.length > 8 ? 8 : widget.performers.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Cada tarjeta ~320px: una sola en móvil, varias en web.
        final fraction =
            (320 / constraints.maxWidth).clamp(0.30, 0.86).toDouble();
        final controller = _controllerFor(fraction);

        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: widget.performers.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (_, i) =>
                    _PerformerPage(performer: widget.performers[i]),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(dotsCount, (i) {
                final active = i == _current;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: active ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active ? CinexaColors.coral : CinexaColors.faint,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}

class _PerformerPage extends StatelessWidget {
  const _PerformerPage({required this.performer});

  final Performer performer;

  @override
  Widget build(BuildContext context) {
    final profilePath = performer.profilePath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => context.push('${Routes.person}/${performer.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (profilePath != null)
                Image.network(
                  '${Constants.imagesBaseUrl}$profilePath',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _avatarPlaceholder(),
                )
              else
                _avatarPlaceholder(),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      performer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (performer.department != null)
                      Text(
                        performer.department!,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                    const SizedBox(height: 8),
                    if (performer.knownFor.isNotEmpty)
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: performer.knownFor.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (_, i) {
                            final poster = performer.knownFor[i].posterPath;
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: poster != null
                                  ? Image.network(
                                      '${Constants.imagesBaseUrl}$poster',
                                      width: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          _smallPlaceholder(),
                                    )
                                  : _smallPlaceholder(),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarPlaceholder() {
    return Assets.branding.placeholders.avatarPlaceholderPng
        .image(fit: BoxFit.cover);
  }

  Widget _smallPlaceholder() {
    return Assets.branding.placeholders.posterPlaceholderPng
        .image(width: 60, fit: BoxFit.cover);
  }
}
