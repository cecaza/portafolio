import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/constants.dart';
import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../services/remote/movies_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._moviesService, this._secureStorage);

  final MoviesService _moviesService;
  final FlutterSecureStorage _secureStorage;

  @override
  Future<Either<HttpFailureType, MovieDetail>> getById(int id) async {
    final sessionId = await _secureStorage.read(key: Constants.sessionKey);
    final result = await _moviesService.getById(id, sessionId: sessionId);
    return result.when(
      (failure) => Left(failure.type),
      (movie) => Right(movie),
    );
  }
}
