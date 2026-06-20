import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/data/repositories_implementation/person_repository_impl.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/person_detail.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockPersonService service;
  late PersonRepositoryImpl repository;

  setUp(() {
    service = MockPersonService();
    repository = PersonRepositoryImpl(service);
  });

  test('getById devuelve el detalle en caso de éxito', () async {
    when(service.getById(any)).thenAnswer(
      (_) async => const Right<HttpFailure, PersonDetail>(
        PersonDetail(id: 1, name: 'Actor'),
      ),
    );

    final result = await repository.getById(1);

    expect(result.isRight, isTrue);
    result.when(
      (_) => fail('no debería fallar'),
      (person) => expect(person.name, 'Actor'),
    );
  });

  test('getById traduce el fallo a HttpFailureType', () async {
    when(service.getById(any)).thenAnswer(
      (_) async => Left<HttpFailure, PersonDetail>(
        HttpFailure(type: HttpFailureType.notFound),
      ),
    );

    final result = await repository.getById(99);

    expect(result.isLeft, isTrue);
    result.when(
      (failure) => expect(failure, HttpFailureType.notFound),
      (_) => fail('no debería tener éxito'),
    );
  });
}
