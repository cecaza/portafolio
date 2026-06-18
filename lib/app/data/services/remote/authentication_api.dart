import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';

/// Encapsula el flujo de autenticación v3 de TheMovieDB:
///   1. Crear request token.
///   2. Validar el token con usuario/contraseña.
///   3. Crear una sesión a partir del token validado.
class AuthenticationAPI {
  AuthenticationAPI(this._http);

  final Http _http;

  /// Paso 1: solicita un nuevo `request_token` temporal.
  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request<String>(
      '/3/authentication/token/new',
      parser: (json) => (json as Json)['request_token'] as String,
    );

    return result.when(
      (failure) => Left(_signInFailureFromHttp(failure)),
      (token) => Right(token),
    );
  }

  /// Paso 2: valida el `request_token` con las credenciales del usuario.
  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request<String>(
      '/3/authentication/token/validate_with_login',
      method: HttpMethod.post,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
      parser: (json) => (json as Json)['request_token'] as String,
    );

    return result.when(
      (failure) => Left(_signInFailureFromHttp(failure)),
      (token) => Right(token),
    );
  }

  /// Paso 3: crea una sesión y devuelve el `session_id`.
  Future<Either<SignInFailure, String>> createSession(
    String requestToken,
  ) async {
    final result = await _http.request<String>(
      '/3/authentication/session/new',
      method: HttpMethod.post,
      body: {'request_token': requestToken},
      parser: (json) => (json as Json)['session_id'] as String,
    );

    return result.when(
      (failure) => Left(_signInFailureFromHttp(failure)),
      (sessionId) => Right(sessionId),
    );
  }

  SignInFailure _signInFailureFromHttp(HttpFailure failure) {
    // TheMovieDB manda un status_code propio dentro del cuerpo del error.
    final data = failure.data;
    if (data is Map && data['status_code'] != null) {
      switch (data['status_code']) {
        case 30: // Invalid username and/or password.
          return SignInFailure.unauthorized;
        case 32: // Email not verified.
          return SignInFailure.notVerified;
        case 33: // Invalid request token.
          return SignInFailure.unknown;
      }
    }
    return switch (failure.type) {
      HttpFailureType.network => SignInFailure.network,
      HttpFailureType.notFound => SignInFailure.notFound,
      HttpFailureType.unauthorized => SignInFailure.unauthorized,
      _ => SignInFailure.unknown,
    };
  }
}
