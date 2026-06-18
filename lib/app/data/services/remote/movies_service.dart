import '../../../domain/either/either.dart';
import '../../../domain/models/movie_detail.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Consulta el detalle de una película de TheMovieDB.
class MoviesService {
  MoviesService(this._http);

  final Http _http;

  Future<Either<HttpFailure, MovieDetail>> getById(
    int id, {
    String? sessionId,
  }) {
    // Con sesión pedimos también account_states para saber si es favorita.
    return _http.request<MovieDetail>(
      '/3/movie/$id',
      queryParameters: {
        'language': 'es-ES',
        'append_to_response':
            sessionId != null ? 'credits,account_states' : 'credits',
        if (sessionId != null) 'session_id': sessionId,
      },
      parser: (json) => MovieDetail.fromJson(json as Json),
    );
  }
}
