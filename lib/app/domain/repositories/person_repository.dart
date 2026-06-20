import '../either/either.dart';
import '../enums.dart';
import '../models/person_detail.dart';

abstract class PersonRepository {
  /// Detalle de una persona por su [id] (incluye filmografía).
  /// En caso de error devuelve un [HttpFailureType] (fallo del dominio).
  Future<Either<HttpFailureType, PersonDetail>> getById(int id);
}
