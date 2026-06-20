import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/movie.dart';
import '../../../../repositories.dart';
import '../../../global/colors.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../../../global/widgets/request_failed.dart';
import '../../../routes/routes.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounce;
  String _query = '';
  Future<Either<HttpFailureType, List<Movie>>>? _future;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      final query = text.trim();
      setState(() {
        _query = query;
        _future =
            query.isEmpty ? null : Repositories.search.searchMovies(query);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: _onChanged,
          decoration: const InputDecoration(
            hintText: 'Buscar películas...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_query.isEmpty || _future == null) {
      return _EmptyState();
    }
    return FutureBuilder<Either<HttpFailureType, List<Movie>>>(
      future: _future,
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CinexaLoader();
        }
        final result = snapshot.data;
        if (result == null) {
          return const SizedBox.shrink();
        }
        return result.when(
          (_) => RequestFailed(
            message: 'No se pudo buscar',
            onRetry: () => setState(() {
              _future = Repositories.search.searchMovies(_query);
            }),
          ),
          (movies) {
            if (movies.isEmpty) {
              return Center(
                child: Text('Sin resultados para "$_query"'),
              );
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
              itemBuilder: (_, i) => _ResultPoster(movie: movies[i]),
            );
          },
        );
      },
    );
  }
}

class _ResultPoster extends StatelessWidget {
  const _ResultPoster({required this.movie});

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

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_filter_outlined,
              size: 64, color: CinexaColors.muted),
          SizedBox(height: 12),
          Text(
            'Busca tu próxima película',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            'Escribe un título arriba',
            style: TextStyle(color: CinexaColors.muted),
          ),
        ],
      ),
    );
  }
}
