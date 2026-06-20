import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/movie.dart';
import 'package:portafolio/app/domain/models/movie_detail.dart';
import 'package:portafolio/app/domain/models/performer.dart';
import 'package:portafolio/app/domain/models/person_detail.dart';
import 'package:portafolio/app/domain/models/user.dart';
import 'package:portafolio/app/domain/typedefs.dart';

/// Mockito necesita un valor "dummy" para los tipos de retorno que no conoce
/// (como nuestro [Either]). Esto los registra una sola vez por archivo de test.
void registerDummies() {
  provideDummy<Either<SignInFailure, String>>(
    const Left<SignInFailure, String>(SignInFailure.unknown),
  );
  provideDummy<Either<SignInFailure, User>>(
    const Left<SignInFailure, User>(SignInFailure.unknown),
  );
  provideDummy<Either<HttpFailure, User>>(
    Left<HttpFailure, User>(HttpFailure()),
  );
  provideDummy<Either<HttpFailure, List<Movie>>>(
    Left<HttpFailure, List<Movie>>(HttpFailure()),
  );
  provideDummy<Either<HttpFailure, List<Performer>>>(
    Left<HttpFailure, List<Performer>>(HttpFailure()),
  );
  provideDummy<Either<HttpFailure, MovieDetail>>(
    Left<HttpFailure, MovieDetail>(HttpFailure()),
  );
  provideDummy<Either<HttpFailure, bool>>(
    Left<HttpFailure, bool>(HttpFailure()),
  );
  provideDummy<Either<HttpFailureType, List<Movie>>>(
    const Left<HttpFailureType, List<Movie>>(HttpFailureType.unknown),
  );
  provideDummy<Either<HttpFailureType, List<Performer>>>(
    const Left<HttpFailureType, List<Performer>>(HttpFailureType.unknown),
  );
  provideDummy<Either<HttpFailure, MoviesPage>>(
    Left<HttpFailure, MoviesPage>(HttpFailure()),
  );
  provideDummy<Either<HttpFailureType, MoviesPage>>(
    const Left<HttpFailureType, MoviesPage>(HttpFailureType.unknown),
  );
  provideDummy<Either<HttpFailure, PersonDetail>>(
    Left<HttpFailure, PersonDetail>(HttpFailure()),
  );
  provideDummy<Either<HttpFailureType, PersonDetail>>(
    const Left<HttpFailureType, PersonDetail>(HttpFailureType.unknown),
  );
}
