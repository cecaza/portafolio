import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/user.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockFlutterSecureStorage storage;
  late MockAuthenticationAPI authApi;
  late MockAccountAPI accountApi;
  late AuthenticationRepositoryImpl repository;

  const user = User(id: 1, name: 'Cesar', username: 'cesar');

  setUp(() {
    storage = MockFlutterSecureStorage();
    authApi = MockAuthenticationAPI();
    accountApi = MockAccountAPI();
    repository = AuthenticationRepositoryImpl(storage, authApi, accountApi);
  });

  group('isSignedIn', () {
    test('true cuando hay session_id guardado', () async {
      when(storage.read(key: anyNamed('key')))
          .thenAnswer((_) async => 'session-123');

      expect(await repository.isSignedIn, isTrue);
    });

    test('false cuando no hay session_id', () async {
      when(storage.read(key: anyNamed('key'))).thenAnswer((_) async => null);

      expect(await repository.isSignedIn, isFalse);
    });
  });

  group('signIn', () {
    test('flujo completo exitoso devuelve el usuario', () async {
      when(authApi.createRequestToken())
          .thenAnswer((_) async => const Right<SignInFailure, String>('req-token'));
      when(authApi.createSessionWithLogin(
        username: anyNamed('username'),
        password: anyNamed('password'),
        requestToken: anyNamed('requestToken'),
      )).thenAnswer((_) async => const Right<SignInFailure, String>('valid-token'));
      when(authApi.createSession(any))
          .thenAnswer((_) async => const Right<SignInFailure, String>('session-123'));
      when(storage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async {});
      when(storage.read(key: anyNamed('key')))
          .thenAnswer((_) async => 'session-123');
      when(accountApi.getAccount(any))
          .thenAnswer((_) async => const Right<HttpFailure, User>(user));

      final result = await repository.signIn('cesar', '1234');

      expect(result.isRight, isTrue);
      result.when(
        (_) => fail('no debería fallar'),
        (u) => expect(u.username, 'cesar'),
      );
      // Guardó la sesión.
      verify(storage.write(key: anyNamed('key'), value: 'session-123'))
          .called(1);
    });

    test('si falla el request token, devuelve el error', () async {
      when(authApi.createRequestToken()).thenAnswer(
          (_) async => const Left<SignInFailure, String>(SignInFailure.network));

      final result = await repository.signIn('cesar', '1234');

      expect(result.isLeft, isTrue);
      result.when(
        (failure) => expect(failure, SignInFailure.network),
        (_) => fail('no debería tener éxito'),
      );
      // No siguió con los siguientes pasos.
      verifyNever(accountApi.getAccount(any));
    });

    test('credenciales inválidas devuelven unauthorized', () async {
      when(authApi.createRequestToken())
          .thenAnswer((_) async => const Right<SignInFailure, String>('req-token'));
      when(authApi.createSessionWithLogin(
        username: anyNamed('username'),
        password: anyNamed('password'),
        requestToken: anyNamed('requestToken'),
      )).thenAnswer(
          (_) async => const Left<SignInFailure, String>(SignInFailure.unauthorized));

      final result = await repository.signIn('cesar', 'mala');

      expect(result.isLeft, isTrue);
      result.when(
        (failure) => expect(failure, SignInFailure.unauthorized),
        (_) => fail('no debería tener éxito'),
      );
    });
  });

  test('signOut borra la sesión', () async {
    when(storage.delete(key: anyNamed('key'))).thenAnswer((_) async {});

    await repository.signOut();

    verify(storage.delete(key: anyNamed('key'))).called(1);
  });
}
