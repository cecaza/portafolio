import '../either/either.dart';
import '../enums.dart';
import '../models/movie.dart';

abstract class TrendingRepository {
  /// Películas en tendencia (día o semana).
  /// En caso de error devuelve un [HttpFailureType] (fallo del dominio).
  Future<Either<HttpFailureType, List<Movie>>> getMovies(TimeWindow timeWindow);
}
