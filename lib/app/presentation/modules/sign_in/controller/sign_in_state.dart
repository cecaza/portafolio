import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

/// Estado INMUTABLE de la pantalla de login (generado con freezed).
@freezed
abstract class SignInState with _$SignInState {
  const SignInState._();

  const factory SignInState({
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool fetching,
  }) = _SignInState;

  /// El formulario es válido si ambos campos cumplen el mínimo.
  bool get isValid => username.length >= 4 && password.length >= 4;
}
