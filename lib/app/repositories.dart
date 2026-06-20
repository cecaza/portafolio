import 'domain/repositories/account_repository.dart';
import 'domain/repositories/authentication_repository.dart';
import 'domain/repositories/categories_repository.dart';
import 'domain/repositories/connectivity_repository.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/repositories/performers_repository.dart';
import 'domain/repositories/person_repository.dart';
import 'domain/repositories/search_repository.dart';
import 'domain/repositories/trending_repository.dart';

/// Service Locator: contiene las instancias de los repositorios de la app.
///
/// Reemplaza la inyección de repositorios con provider. Al ser global (no
/// depende del árbol de widgets), facilita los tests: basta con asignar mocks
/// a estas variables antes de cada prueba.
///
/// Se inicializa una vez en `main()`.
class Repositories {
  Repositories._();

  static late ConnectivityRepository connectivity;
  static late AuthenticationRepository authentication;
  static late AccountRepository account;
  static late TrendingRepository trending;
  static late CategoriesRepository categories;
  static late PerformersRepository performers;
  static late PersonRepository person;
  static late MovieRepository movie;
  static late SearchRepository search;
}
