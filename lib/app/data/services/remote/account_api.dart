import '../../../domain/either/either.dart';
import '../../../domain/models/movie.dart';
import '../../../domain/models/user.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Consulta los datos de la cuenta autenticada en TheMovieDB.
class AccountAPI {
  AccountAPI(this._http);

  final Http _http;

  /// Obtiene los datos del usuario asociado a la sesión [sessionId].
  Future<Either<HttpFailure, User>> getAccount(String sessionId) {
    return _http.request<User>(
      '/3/account',
      queryParameters: {'session_id': sessionId},
      parser: (json) => User.fromJson(json as Json),
    );
  }

  /// Lista las películas favoritas de la cuenta.
  Future<Either<HttpFailure, List<Movie>>> getFavorites({
    required int accountId,
    required String sessionId,
  }) {
    return _http.request<List<Movie>>(
      '/3/account/$accountId/favorite/movies',
      queryParameters: {'session_id': sessionId, 'language': 'es-ES'},
      parser: (json) {
        final results = (json as Json)['results'] as List<dynamic>;
        return results.map((e) => Movie.fromJson(e as Json)).toList();
      },
    );
  }

  /// Marca o desmarca una película como favorita.
  Future<Either<HttpFailure, bool>> markAsFavorite({
    required int accountId,
    required String sessionId,
    required int movieId,
    required bool favorite,
  }) {
    return _http.request<bool>(
      '/3/account/$accountId/favorite',
      method: HttpMethod.post,
      queryParameters: {'session_id': sessionId},
      body: {
        'media_type': 'movie',
        'media_id': movieId,
        'favorite': favorite,
      },
      parser: (json) => ((json as Json)['success'] as bool?) ?? true,
    );
  }
}
