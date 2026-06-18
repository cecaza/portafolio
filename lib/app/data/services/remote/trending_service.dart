import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/movie.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Consulta las películas en tendencia de TheMovieDB.
class TrendingService {
  TrendingService(this._http);

  final Http _http;

  /// Películas en tendencia del día o de la semana.
  Future<Either<HttpFailure, List<Movie>>> getMovies(TimeWindow timeWindow) {
    return _http.request<List<Movie>>(
      '/3/trending/movie/${timeWindow.name}',
      queryParameters: {'language': 'es-ES'},
      parser: (json) {
        final results = (json as Json)['results'] as List<dynamic>;
        return results
            .map((e) => Movie.fromJson(e as Json))
            .toList();
      },
    );
  }
}
