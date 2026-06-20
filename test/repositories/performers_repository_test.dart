import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/data/repositories_implementation/performers_repository_impl.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/performer.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockPerformersService service;
  late PerformersRepositoryImpl repository;

  setUp(() {
    service = MockPerformersService();
    repository = PerformersRepositoryImpl(service);
  });

  test('getPerformers devuelve la lista en caso de éxito', () async {
    when(service.getPerformers(any)).thenAnswer(
      (_) async => const Right<HttpFailure, List<Performer>>(
        [Performer(id: 1, name: 'Actor')],
      ),
    );

    final result = await repository.getPerformers(TimeWindow.day);

    expect(result.isRight, isTrue);
    result.when((_) => fail('no debería fallar'),
        (list) => expect(list.first.name, 'Actor'));
  });

  test('getPerformers traduce el fallo a HttpFailureType', () async {
    when(service.getPerformers(any)).thenAnswer(
      (_) async => Left<HttpFailure, List<Performer>>(
        HttpFailure(type: HttpFailureType.network),
      ),
    );

    final result = await repository.getPerformers(TimeWindow.day);

    expect(result.isLeft, isTrue);
    result.when((failure) => expect(failure, HttpFailureType.network),
        (_) => fail('no debería tener éxito'));
  });
}
