import 'either/either.dart';
import 'enums.dart';
import 'models/movie.dart';
import 'models/user.dart';

/// Resultado del inicio de sesión: error [SignInFailure] o el [User] logueado.
typedef Result<L, R> = Either<L, R>;

typedef SignInResult = Either<SignInFailure, User>;

/// JSON genérico devuelto por la API.
typedef Json = Map<String, dynamic>;

/// Una página de resultados de películas (para listas paginadas/scroll infinito).
typedef MoviesPage = ({List<Movie> movies, int page, int totalPages});
