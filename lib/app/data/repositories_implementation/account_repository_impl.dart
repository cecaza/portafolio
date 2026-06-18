import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/constants.dart';
import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/movie.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._secureStorage, this._accountAPI);

  final FlutterSecureStorage _secureStorage;
  final AccountAPI _accountAPI;

  @override
  Future<Either<HttpFailureType, List<Movie>>> getFavorites(
    int accountId,
  ) async {
    final sessionId = await _secureStorage.read(key: Constants.sessionKey);
    if (sessionId == null) {
      return const Left(HttpFailureType.unauthorized);
    }
    final result = await _accountAPI.getFavorites(
      accountId: accountId,
      sessionId: sessionId,
    );
    return result.when(
      (failure) => Left(failure.type),
      (movies) => Right(movies),
    );
  }

  @override
  Future<Either<HttpFailureType, bool>> markAsFavorite(
    int accountId,
    int movieId,
    bool favorite,
  ) async {
    final sessionId = await _secureStorage.read(key: Constants.sessionKey);
    if (sessionId == null) {
      return const Left(HttpFailureType.unauthorized);
    }
    final result = await _accountAPI.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      movieId: movieId,
      favorite: favorite,
    );
    return result.when(
      (failure) => Left(failure.type),
      (success) => Right(success),
    );
  }
}
