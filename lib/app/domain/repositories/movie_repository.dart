import '../either/either.dart';
import '../enums.dart';
import '../models/movie_detail.dart';

abstract class MovieRepository {
  /// Detalle de una película por su id.
  Future<Either<HttpFailureType, MovieDetail>> getById(int id);
}
