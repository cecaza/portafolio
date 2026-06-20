import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/user.dart';
import 'package:portafolio/app/presentation/modules/sign_in/controller/sign_in_controller.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockAuthenticationRepository repository;
  late SignInController controller;

  const user = User(id: 1, name: 'Cesar', username: 'cesar');

  setUp(() {
    repository = MockAuthenticationRepository();
    controller = SignInController(repository);
  });

  test('onUsernameChanged normaliza y guarda el usuario', () {
    controller.onUsernameChanged('  Cesar  ');
    expect(controller.state.username, 'cesar');
  });

  test('isValid es true con usuario y contraseña válidos', () {
    controller.onUsernameChanged('cesar');
    controller.onPasswordChanged('1234');
    expect(controller.state.isValid, isTrue);
  });

  test('submit exitoso devuelve el usuario y apaga fetching', () async {
    when(repository.signIn(any, any))
        .thenAnswer((_) async => const Right<SignInFailure, User>(user));
    controller.onUsernameChanged('cesar');
    controller.onPasswordChanged('1234');

    final result = await controller.submit();

    expect(result.isRight, isTrue);
    expect(controller.state.fetching, isFalse);
    verify(repository.signIn('cesar', '1234')).called(1);
  });

  test('submit con error devuelve el fallo', () async {
    when(repository.signIn(any, any)).thenAnswer(
        (_) async => const Left<SignInFailure, User>(SignInFailure.unauthorized));
    controller.onUsernameChanged('cesar');
    controller.onPasswordChanged('mala');

    final result = await controller.submit();

    expect(result.isLeft, isTrue);
    expect(controller.state.fetching, isFalse);
  });
}
