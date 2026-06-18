import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/performer.dart';
import '../../domain/repositories/performers_repository.dart';
import '../services/remote/performers_service.dart';

class PerformersRepositoryImpl implements PerformersRepository {
  PerformersRepositoryImpl(this._performersService);

  final PerformersService _performersService;

  @override
  Future<Either<HttpFailureType, List<Performer>>> getPerformers(
    TimeWindow timeWindow,
  ) async {
    final result = await _performersService.getPerformers(timeWindow);
    return result.when(
      (failure) => Left(failure.type),
      (performers) => Right(performers),
    );
  }
}
