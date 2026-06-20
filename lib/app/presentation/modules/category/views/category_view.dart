import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/constants.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/movie.dart';
import '../../../../repositories.dart';
import '../../../global/widgets/cinexa_loader.dart';
import '../../../global/widgets/request_failed.dart';
import '../../../routes/routes.dart';

/// Catálogo paginado de una categoría con SCROLL INFINITO.
///
/// Carga la primera página al iniciar y va pidiendo las siguientes a medida
/// que el usuario se acerca al final de la grilla, hasta agotar `totalPages`.
class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.category});

  final MovieCategory category;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final _scrollController = ScrollController();
  final _movies = <Movie>[];

  int _page = 0;
  int _totalPages = 1;
  bool _loading = false;
  bool _failed = false;

  bool get _hasMore => _page < _totalPages;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadNextPage();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    // A 400px del final pedimos la siguiente página.
    if (position.pixels >= position.maxScrollExtent - 400) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    if (_loading || !_hasMore) return;
    setState(() {
      _loading = true;
      _failed = false;
    });

    final result = await Repositories.categories.getMovies(
      widget.category,
      page: _page + 1,
    );

    if (!mounted) return;
    result.when(
      (_) => setState(() {
        _loading = false;
        _failed = true;
      }),
      (data) => setState(() {
        _loading = false;
        _page = data.page;
        _totalPages = data.totalPages;
        _movies.addAll(data.movies);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.label)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_movies.isEmpty) {
      if (_loading) return const CinexaLoader();
      if (_failed) {
        return RequestFailed(
          message: 'No se pudo cargar ${widget.category.label}',
          onRetry: _loadNextPage,
        );
      }
      return const SizedBox.shrink();
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 0.55,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      // Una celda extra para el indicador de carga / reintento del final.
      itemCount: _movies.length + (_hasMore || _failed ? 1 : 0),
      itemBuilder: (_, i) {
        if (i >= _movies.length) return _FooterCell(failed: _failed);
        return _Poster(movie: _movies[i]);
      },
    );
  }
}

class _FooterCell extends StatelessWidget {
  const _FooterCell({required this.failed});

  final bool failed;

  @override
  Widget build(BuildContext context) {
    if (failed) {
      return const Center(
        child: Icon(Icons.error_outline, color: Colors.redAccent),
      );
    }
    return const Center(
      child: SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({required this.movie});

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
