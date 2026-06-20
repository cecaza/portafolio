import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:portafolio/app/data/services/remote/account_api.dart';
import 'package:portafolio/app/data/services/remote/authentication_api.dart';
import 'package:portafolio/app/data/services/remote/categories_service.dart';
import 'package:portafolio/app/data/services/remote/internet_checker.dart';
import 'package:portafolio/app/data/services/remote/movies_service.dart';
import 'package:portafolio/app/data/services/remote/performers_service.dart';
import 'package:portafolio/app/data/services/remote/person_service.dart';
import 'package:portafolio/app/data/services/remote/trending_service.dart';
import 'package:portafolio/app/domain/repositories/authentication_repository.dart';
import 'package:portafolio/app/domain/repositories/categories_repository.dart';
import 'package:portafolio/app/domain/repositories/performers_repository.dart';
import 'package:portafolio/app/domain/repositories/trending_repository.dart';

/// Mocks reutilizables para todos los tests. Se generan con:
///   dart run build_runner build
@GenerateMocks([
  // Dependencias de los repositorios.
  Connectivity,
  InternetChecker,
  FlutterSecureStorage,
  AuthenticationAPI,
  AccountAPI,
  TrendingService,
  PerformersService,
  MoviesService,
  CategoriesService,
  PersonService,
  // Repositorios (para testear controllers).
  AuthenticationRepository,
  TrendingRepository,
  PerformersRepository,
  CategoriesRepository,
])
void main() {}
