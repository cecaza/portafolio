import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/performer.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Consulta las personas (actores, directores...) en tendencia de TheMovieDB.
class PerformersService {
  PerformersService(this._http);

  final Http _http;

  /// Personas populares.
  ///
  /// Nota: usamos `/person/popular` (no `/trending/person`) porque este SÍ
  /// incluye el arreglo `known_for` con las películas/series de cada persona.
  /// El parámetro [timeWindow] se mantiene por consistencia pero aquí no aplica.
  Future<Either<HttpFailure, List<Performer>>> getPerformers(
    TimeWindow timeWindow,
  ) {
    return _http.request<List<Performer>>(
      '/3/person/popular',
      queryParameters: {'language': 'es-ES', 'page': '1'},
      parser: (json) {
        final results = (json as Json)['results'] as List<dynamic>;
        return results
            .map((e) => Performer.fromJson(e as Json))
            .toList();
      },
    );
  }
}
