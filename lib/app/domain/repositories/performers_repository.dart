import '../either/either.dart';
import '../enums.dart';
import '../models/performer.dart';

abstract class PerformersRepository {
  /// Personas en tendencia (día o semana).
  Future<Either<HttpFailureType, List<Performer>>> getPerformers(
    TimeWindow timeWindow,
  );
}
