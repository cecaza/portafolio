import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/data/repositories_implementation/movie_repository_impl.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/movie_detail.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockMoviesService service;
  late MockFlutterSecureStorage storage;
  late MovieRepositoryImpl repository;

  setUp(() {
    service = MockMoviesService();
    storage = MockFlutterSecureStorage();
    repository = MovieRepositoryImpl(service, storage);
  });

  test('getById devuelve el detalle en caso de éxito', () async {
    when(storage.read(key: anyNamed('key'))).thenAnswer((_) async => 'sid');
    when(service.getById(any, sessionId: anyNamed('sessionId'))).thenAnswer(
      (_) async => const Right<HttpFailure, MovieDetail>(
        MovieDetail(id: 1, title: 'Peli'),
      ),
    );

    final result = await repository.getById(1);

    expect(result.isRight, isTrue);
    result.when((_) => fail('no debería fallar'),
        (detail) => expect(detail.title, 'Peli'));
  });

  test('getById traduce el fallo a HttpFailureType', () async {
    when(storage.read(key: anyNamed('key'))).thenAnswer((_) async => null);
    when(service.getById(any, sessionId: anyNamed('sessionId'))).thenAnswer(
      (_) async => Left<HttpFailure, MovieDetail>(
        HttpFailure(type: HttpFailureType.notFound),
      ),
    );

    final result = await repository.getById(999);

    expect(result.isLeft, isTrue);
    result.when((failure) => expect(failure, HttpFailureType.notFound),
        (_) => fail('no debería tener éxito'));
  });
}
