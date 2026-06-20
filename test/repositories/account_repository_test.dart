import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/movie.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockFlutterSecureStorage storage;
  late MockAccountAPI accountApi;
  late AccountRepositoryImpl repository;

  setUp(() {
    storage = MockFlutterSecureStorage();
    accountApi = MockAccountAPI();
    repository = AccountRepositoryImpl(storage, accountApi);
  });

  group('getFavorites', () {
    test('devuelve las películas favoritas', () async {
      when(storage.read(key: anyNamed('key'))).thenAnswer((_) async => 'sid');
      when(accountApi.getFavorites(
        accountId: anyNamed('accountId'),
        sessionId: anyNamed('sessionId'),
      )).thenAnswer(
        (_) async =>
            const Right<HttpFailure, List<Movie>>([Movie(id: 1, title: 'A')]),
      );

      final result = await repository.getFavorites(99);

      expect(result.isRight, isTrue);
      result.when((_) => fail('no debería fallar'),
          (movies) => expect(movies.length, 1));
    });

    test('sin sesión devuelve unauthorized', () async {
      when(storage.read(key: anyNamed('key'))).thenAnswer((_) async => null);

      final result = await repository.getFavorites(99);

      expect(result.isLeft, isTrue);
      result.when((f) => expect(f, HttpFailureType.unauthorized),
          (_) => fail('no debería tener éxito'));
      verifyNever(accountApi.getFavorites(
        accountId: anyNamed('accountId'),
        sessionId: anyNamed('sessionId'),
      ));
    });
  });

  group('markAsFavorite', () {
    test('marca favorito correctamente', () async {
      when(storage.read(key: anyNamed('key'))).thenAnswer((_) async => 'sid');
      when(accountApi.markAsFavorite(
        accountId: anyNamed('accountId'),
        sessionId: anyNamed('sessionId'),
        movieId: anyNamed('movieId'),
        favorite: anyNamed('favorite'),
      )).thenAnswer((_) async => const Right<HttpFailure, bool>(true));

      final result = await repository.markAsFavorite(99, 1, true);

      expect(result.isRight, isTrue);
    });
  });
}
