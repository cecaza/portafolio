import 'package:flutter/foundation.dart';

import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/typedefs.dart';
import 'sign_in_state.dart';

/// Controla la lógica de la pantalla de login.
///
/// Es un [ChangeNotifier]: cuando su estado cambia llama a [notifyListeners]
/// y la UI suscrita se redibuja (equivalente a `INotifyPropertyChanged`).
class SignInController extends ChangeNotifier {
  SignInController(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  SignInState _state = const SignInState();
  SignInState get state => _state;

  /// El usuario escribió en el campo de username.
  void onUsernameChanged(String text) {
    _state = _state.copyWith(username: text.trim().toLowerCase());
    notifyListeners();
  }

  /// El usuario escribió en el campo de password.
  void onPasswordChanged(String text) {
    _state = _state.copyWith(password: text.replaceAll(' ', '').toLowerCase());
    notifyListeners();
  }

  /// Intenta iniciar sesión con el estado actual.
  /// Devuelve el resultado para que la vista navegue o muestre el error.
  Future<SignInResult> submit() async {
    _state = _state.copyWith(fetching: true);
    notifyListeners();

    final result = await _authenticationRepository.signIn(
      _state.username,
      _state.password,
    );

    _state = _state.copyWith(fetching: false);
    notifyListeners();

    return result;
  }
}
