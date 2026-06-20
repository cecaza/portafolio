import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/movie.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Consulta las listas paginadas de películas de TheMovieDB
/// (en cartelera, mejor valoradas, próximamente, populares).
class CategoriesService {
  CategoriesService(this._http);

  final Http _http;

  Future<Either<HttpFailure, MoviesPage>> getMovies(
    MovieCategory category, {
    int page = 1,
  }) {
    return _http.request<MoviesPage>(
      '/3/movie/${category.path}',
      queryParameters: {
        'language': 'es-ES',
        'page': '$page',
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
