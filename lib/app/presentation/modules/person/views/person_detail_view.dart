import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/person_detail.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../../../global/widgets/request_failed.dart';
import '../../../routes/routes.dart';

/// A partir de este ancho usamos diseño de escritorio/web.
const double _wideBreakpoint = 760;

/// Ancho máximo del contenido (para que no se estire en pantallas grandes).
const double _maxContentWidth = 1000;

/// Detalle de una persona: foto, datos, biografía y filmografía (tocando una
/// película navega a su detalle). Es responsive: en web centra el contenido y
/// muestra la foto al lado de los datos.
class PersonDetailView extends StatefulWidget {
  const PersonDetailView({super.key, required this.personId});

  final int personId;

  @override
  State<PersonDetailView> createState() => _PersonDetailViewState();
}

class _PersonDetailViewState extends State<PersonDetailView> {
  Future<Either<HttpFailureType, PersonDetail>>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future ??= Repositories.person.getById(widget.personId);
  }

  void _reload() {
    setState(() {
      _future = Repositories.person.getById(widget.personId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(onPressed: () => context.pop()),
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<Either<HttpFailureType, PersonDetail>>(
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
              message: 'No se pudo cargar la persona',
              onRetry: _reload,
            ),
            (person) => _PersonBody(person: person),
          );
        },
      ),
    );
  }
}

class _PersonBody extends StatelessWidget {
  const _PersonBody({required this.person});

  final PersonDetail person;

  @override
  Widget build(BuildContext context) {
    // Filmografía ordenada por calificación (las mejores primero).
    final movies = [...person.movies]
      ..sort((a, b) => b.voteAverage.compareTo(a.voteAverage));

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideBreakpoint;

        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 72, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(person: person, isWide: isWide),
                    if (person.biography.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Biografía',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        person.biography,
                        style: const TextStyle(height: 1.4),
                      ),
                    ],
                    if (movies.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Filmografía',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 130,
                              childAspectRatio: 0.55,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemCount: movies.length,
                        itemBuilder: (_, i) => _MoviePoster(movie: movies[i]),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Cabecera: foto + nombre/datos. En web van lado a lado; en móvil, apilados.
class _Header extends StatelessWidget {
  const _Header({required this.person, required this.isWide});

  final PersonDetail person;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final photo = _Photo(profilePath: person.profilePath);
    final info = _Info(person: person);

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 200, child: photo),
          const SizedBox(width: 24),
          Expanded(child: info),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: SizedBox(width: 180, child: photo)),
        const SizedBox(height: 16),
        info,
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.profilePath});

  final String? profilePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: profilePath != null
            ? Image.network(
                '${Constants.imagesBaseUrl}$profilePath',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Assets.branding.placeholders.avatarPlaceholderPng
        .image(fit: BoxFit.cover);
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.person});

  final PersonDetail person;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          person.name,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (person.department != null) ...[
          const SizedBox(height: 4),
          Text(
            person.department!,
            style: const TextStyle(color: CinexaColors.muted, fontSize: 14),
          ),
        ],
        const SizedBox(height: 12),
        if ((person.birthday ?? '').isNotEmpty)
          _Fact(icon: Icons.cake_outlined, text: person.birthday!),
        if ((person.placeOfBirth ?? '').isNotEmpty)
          _Fact(icon: Icons.place_outlined, text: person.placeOfBirth!),
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: CinexaColors.coral),
          const SizedBox(width: 6),
          Flexible(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({required this.movie});

  final PersonMovie movie;

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
                errorBuilder: (_, __, ___) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Assets.branding.placeholders.posterPlaceholderPng
        .image(fit: BoxFit.cover);
  }
}
