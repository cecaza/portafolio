import '../either/either.dart';
import '../enums.dart';
import '../models/movie.dart';

abstract class AccountRepository {
  /// Películas favoritas de la cuenta [accountId].
  Future<Either<HttpFailureType, List<Movie>>> getFavorites(int accountId);

  /// Marca/desmarca una película como favorita.
  Future<Either<HttpFailureType, bool>> markAsFavorite(
    int accountId,
    int movieId,
    bool favorite,
  );
}
