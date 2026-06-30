import '../../../domain/either/either.dart';
import '../../../domain/models/discover_filter.dart';
import '../../../domain/models/movie.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Descubre películas según [DiscoverFilter] (géneros, nota mínima) usando el
/// endpoint `/discover/movie` de TheMovieDB. Devuelve páginas para poder
/// rellenar el deck de swipe de forma "infinita".
class DiscoverService {
  DiscoverService(this._http);

  final Http _http;

  Future<Either<HttpFailure, MoviesPage>> getMovies(
    DiscoverFilter filter, {
    int page = 1,
  }) {
    return _http.request<MoviesPage>(
      '/3/discover/movie',
      queryParameters: {
        'language': 'es-ES',
        'page': '$page',
        'sort_by': 'popularity.desc',
        'include_adult': 'false',
        if (filter.genres.isNotEmpty) 'with_genres': filter.genresParam,
        if (filter.minVoteAverage != null)
          'vote_average.gte': '${filter.minVoteAverage}',
        // Evita rarezas con muy pocos votos cuando se filtra por nota.
        if (filter.minVoteAverage != null) 'vote_count.gte': '100',
      },
      parser: (json) {
        final map = json as Json;
        final results = (map['results'] as List<dynamic>)
            .map((e) => Movie.fromJson(e as Json))
            .toList();
        return (
          movies: results,
          page: map['page'] as int,
          totalPages: map['total_pages'] as int,
        );
      },
    );
  }
}
