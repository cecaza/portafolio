import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/person_detail.dart';
import '../../domain/repositories/person_repository.dart';
import '../services/remote/person_service.dart';

class PersonRepositoryImpl implements PersonRepository {
  PersonRepositoryImpl(this._personService);

  final PersonService _personService;

  @override
  Future<Either<HttpFailureType, PersonDetail>> getById(int id) async {
    final result = await _personService.getById(id);
    // Traducimos el fallo técnico (data) a un fallo del dominio.
    return result.when(
      (failure) => Left(failure.type),
      (person) => Right(person),
    );
  }
}
