import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/discover_filter.dart';
import '../../domain/repositories/discover_repository.dart';
import '../../domain/typedefs.dart';
import '../services/remote/discover_service.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  DiscoverRepositoryImpl(this._discoverService);

  final DiscoverService _discoverService;

  @override
  Future<Either<HttpFailureType, MoviesPage>> getMovies(
    DiscoverFilter filter, {
    int page = 1,
  }) async {
    final result = await _discoverService.getMovies(filter, page: page);
    return result.when(
      (failure) => Left(failure.type),
      (page) => Right(page),
    );
  }
}
