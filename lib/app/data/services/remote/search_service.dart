import '../../../domain/either/either.dart';
import '../../../domain/models/movie.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Busca películas en TheMovieDB.
class SearchService {
  SearchService(this._http);

  final Http _http;

  Future<Either<HttpFailure, List<Movie>>> searchMovies(
    String query, {
    int page = 1,
  }) {
    return _http.request<List<Movie>>(
      '/3/search/movie',
      queryParameters: {
        'query': query,
        'language': 'es-ES',
        'page': '$page',
        'include_adult': 'false',
      },
      parser: (json) {
        final results = (json as Json)['results'] as List<dynamic>;
        return results.map((e) => Movie.fromJson(e as Json)).toList();
      },
    );
  }
}
