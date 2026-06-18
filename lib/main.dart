import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/config/constants.dart';
import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/movie_repository_impl.dart';
import 'app/data/repositories_implementation/performers_repository_impl.dart';
import 'app/data/repositories_implementation/trending_repository_impl.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movies_service.dart';
import 'app/data/services/remote/performers_service.dart';
import 'app/data/services/remote/trending_service.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/movie_repository.dart';
import 'app/domain/repositories/performers_repository.dart';
import 'app/domain/repositories/trending_repository.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';
import 'app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  const secureStorage = FlutterSecureStorage();
  final client = Client();
  final http = Http(
    client: client,
    baseUrl: Constants.baseUrl,
    accessToken: Constants.accessToken,
  );

  runApp(
    MultiProvider(
      providers: [
        // Repositorios (inyección de dependencias con provider).
        Provider<ConnectivityRepository>(
          create: (_) => ConnectivityRepositoryImpl(
            Connectivity(),
            InternetChecker(),
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImpl(
            secureStorage,
            AuthenticationAPI(http),
            AccountAPI(http),
          ),
        ),
        Provider<TrendingRepository>(
          create: (_) => TrendingRepositoryImpl(
            TrendingService(http),
          ),
        ),
        Provider<PerformersRepository>(
          create: (_) => PerformersRepositoryImpl(
            PerformersService(http),
          ),
        ),
        Provider<MovieRepository>(
          create: (_) => MovieRepositoryImpl(
            MoviesService(http),
            secureStorage,
          ),
        ),
        Provider<AccountRepository>(
          create: (_) => AccountRepositoryImpl(
            secureStorage,
            AccountAPI(http),
          ),
        ),
        // Estado global de la sesión.
        ChangeNotifierProvider<SessionController>(
          create: (_) => SessionController(),
        ),
        // Tema (claro/oscuro) persistido.
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(prefs),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
