import '../either/either.dart';
import '../enums.dart';
import '../models/discover_filter.dart';
import '../typedefs.dart';

abstract class DiscoverRepository {
  /// Descubre películas según [filter] (géneros, nota mínima), paginadas.
  /// En caso de error devuelve un [HttpFailureType] (fallo del dominio).
  Future<Either<HttpFailureType, MoviesPage>> getMovies(
    DiscoverFilter filter, {
    int page = 1,
  });
}
