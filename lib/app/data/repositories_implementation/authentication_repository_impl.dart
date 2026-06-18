import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/constants.dart';
import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/typedefs.dart';
import '../services/remote/account_api.dart';
import '../services/remote/authentication_api.dart';

const _key = Constants.sessionKey;

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._secureStorage,
    this._authenticationAPI,
    this._accountAPI,
  );

  final FlutterSecureStorage _secureStorage;
  final AuthenticationAPI _authenticationAPI;
  final AccountAPI _accountAPI;

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<User?> getUserData() async {
    final sessionId = await _secureStorage.read(key: _key);
    if (sessionId == null) {
      return null;
    }
    final result = await _accountAPI.getAccount(sessionId);
    return result.when(
      (_) => null,
      (user) => user,
    );
  }

  @override
  Future<SignInResult> signIn(String username, String password) async {
    // Paso 1: request token.
    final requestTokenResult = await _authenticationAPI.createRequestToken();
    if (requestTokenResult is Left<SignInFailure, String>) {
      return Left(requestTokenResult.value);
    }
    final requestToken =
        (requestTokenResult as Right<SignInFailure, String>).value;

    // Paso 2: validar token con credenciales.
    final loginResult = await _authenticationAPI.createSessionWithLogin(
      username: username,
      password: password,
      requestToken: requestToken,
    );
    if (loginResult is Left<SignInFailure, String>) {
      return Left(loginResult.value);
    }
    final validatedToken = (loginResult as Right<SignInFailure, String>).value;

    // Paso 3: crear sesión.
    final sessionResult = await _authenticationAPI.createSession(validatedToken);
    if (sessionResult is Left<SignInFailure, String>) {
      return Left(sessionResult.value);
    }
    final sessionId = (sessionResult as Right<SignInFailure, String>).value;

    // Guardamos la sesión y obtenemos el usuario.
    await _secureStorage.write(key: _key, value: sessionId);
    final user = await getUserData();
    if (user == null) {
      return const Left(SignInFailure.unknown);
    }
    return Right(user);
  }

  @override
  Future<void> signOut() {
    return _secureStorage.delete(key: _key);
  }
}
