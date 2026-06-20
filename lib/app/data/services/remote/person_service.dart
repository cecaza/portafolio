import '../../../domain/either/either.dart';
import '../../../domain/models/person_detail.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Consulta el detalle de una persona de TheMovieDB (con su filmografía).
class PersonService {
  PersonService(this._http);

  final Http _http;

  Future<Either<HttpFailure, PersonDetail>> getById(int id) {
    return _http.request<PersonDetail>(
      '/3/person/$id',
      queryParameters: {
        'language': 'es-ES',
        'append_to_response': 'movie_credits',
      },
      parser: (json) => PersonDetail.fromJson(json as Json),
    );
  }
}
