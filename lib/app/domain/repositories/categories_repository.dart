import '../either/either.dart';
import '../enums.dart';
import '../typedefs.dart';

abstract class CategoriesRepository {
  /// Devuelve una página de películas de la [category] indicada.
  /// En caso de error devuelve un [HttpFailureType] (fallo del dominio).
  Future<Either<HttpFailureType, MoviesPage>> getMovies(
    MovieCategory category, {
    int page,
  });
}
