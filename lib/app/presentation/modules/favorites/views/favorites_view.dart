import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/movie.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../../../global/widgets/request_failed.dart';
import '../../../routes/routes.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  Future<Either<HttpFailureType, List<Movie>>>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future ??= _fetch();
  }

  Future<Either<HttpFailureType, List<Movie>>> _fetch() {
    final accountId = context.read<SessionController>().user?.id ?? 0;
    return Repositories.account.getFavorites(accountId);
  }

  Future<void> _refresh() async {
    setState(() => _future = _fetch());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    // Los favoritos son de la cuenta TMDB: sin sesión, invitamos a entrar.
    final isSignedIn = context.watch<SessionController>().isSignedIn;
    if (!isSignedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Favoritos')),
        body: _SignInPrompt(),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<Either<HttpFailureType, List<Movie>>>(
          future: _future,
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CinexaLoader();
            }
            final result = snapshot.data;
            if (result == null) {
              return RequestFailed(onRetry: _refresh);
            }
            return result.when(
              (_) => RequestFailed(
                message: 'No se pudieron cargar tus favoritos',
                onRetry: _refresh,
              ),
              (movies) {
                if (movies.isEmpty) {
                  return _EmptyFavorites();
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (_, i) => _FavoritePoster(movie: movies[i]),
                );
              },
            );
          },
        ),
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

class _SignInPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.branding.placeholders.emptyStatePng.image(width: 160),
            const SizedBox(height: 16),
            const Text(
              'Inicia sesión para tus favoritos',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Los favoritos se guardan en tu cuenta de TMDB. '
              'Puedes usar el resto de la app sin iniciar sesión.',
              textAlign: TextAlign.center,
              style: TextStyle(color: CinexaColors.muted),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => context.go(Routes.signIn),
              icon: const Icon(Icons.login),
              label: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
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
