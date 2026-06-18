import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/movie.dart';
import '../../domain/repositories/trending_repository.dart';
import '../services/remote/trending_service.dart';

class TrendingRepositoryImpl implements TrendingRepository {
  TrendingRepositoryImpl(this._trendingService);

  final TrendingService _trendingService;

  @override
  Future<Either<HttpFailureType, List<Movie>>> getMovies(
    TimeWindow timeWindow,
  ) async {
    final result = await _trendingService.getMovies(timeWindow);
    // Traducimos el fallo técnico (data) a un fallo del dominio.
    return result.when(
      (failure) => Left(failure.type),
      (movies) => Right(movies),
    );
  }
}
