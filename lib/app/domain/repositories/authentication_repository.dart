import '../models/user.dart';
import '../typedefs.dart';

abstract class AuthenticationRepository {
  /// `true` si existe una sesión guardada localmente.
  Future<bool> get isSignedIn;

  /// Obtiene los datos del usuario de la sesión actual (o `null`).
  Future<User?> getUserData();

  /// Inicia sesión contra TheMovieDB. Devuelve el [User] o un [SignInFailure].
  Future<SignInResult> signIn(String username, String password);

  /// Cierra la sesión y borra las credenciales locales.
  Future<void> signOut();
}
