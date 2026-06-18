import 'either/either.dart';
import 'enums.dart';
import 'models/user.dart';

/// Resultado del inicio de sesión: error [SignInFailure] o el [User] logueado.
typedef Result<L, R> = Either<L, R>;

typedef SignInResult = Either<SignInFailure, User>;

/// JSON genérico devuelto por la API.
typedef Json = Map<String, dynamic>;
