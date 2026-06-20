import '../either/either.dart';
import '../enums.dart';
import '../models/movie.dart';

abstract class SearchRepository {
  /// Busca películas por texto.
  Future<Either<HttpFailureType, List<Movie>>> searchMovies(
    String query, {
    int page = 1,
  });
}
