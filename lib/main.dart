import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/config/constants.dart';
import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/categories_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/discover_repository_impl.dart';
import 'app/data/repositories_implementation/match_repository_impl.dart';
import 'app/data/repositories_implementation/movie_repository_impl.dart';
import 'app/data/repositories_implementation/performers_repository_impl.dart';
import 'app/data/repositories_implementation/person_repository_impl.dart';
import 'app/data/repositories_implementation/search_repository_impl.dart';
import 'app/data/repositories_implementation/trending_repository_impl.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/categories_service.dart';
import 'app/data/services/remote/discover_service.dart';
import 'app/data/services/remote/firestore_match_service.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movies_service.dart';
import 'app/data/services/remote/performers_service.dart';
import 'app/data/services/remote/person_service.dart';
import 'app/data/services/remote/search_service.dart';
import 'app/data/services/remote/trending_service.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';
import 'app/presentation/global/pwa/pwa.dart';
import 'app/my_app.dart';
import 'app/repositories.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initPwa(); // escucha el evento de instalación en web (no-op en móvil)

  // Firebase: necesario para el módulo de match (auth anónima + Firestore).
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  const secureStorage = FlutterSecureStorage();
  final client = Client();
  final http = Http(
    client: client,
    baseUrl: Constants.baseUrl,
    accessToken: Constants.accessToken,
  );

  // Inicializamos el Service Locator de repositorios.
  Repositories.connectivity = ConnectivityRepositoryImpl(
    Connectivity(),
    InternetChecker(),
  );
  Repositories.authentication = AuthenticationRepositoryImpl(
    secureStorage,
    AuthenticationAPI(http),
    AccountAPI(http),
  );
  Repositories.account = AccountRepositoryImpl(
    secureStorage,
    AccountAPI(http),
  );
  Repositories.trending = TrendingRepositoryImpl(TrendingService(http));
  Repositories.categories =
      CategoriesRepositoryImpl(CategoriesService(http));
  Repositories.performers = PerformersRepositoryImpl(PerformersService(http));
  Repositories.person = PersonRepositoryImpl(PersonService(http));
  Repositories.movie = MovieRepositoryImpl(MoviesService(http), secureStorage);
  Repositories.search = SearchRepositoryImpl(SearchService(http));
  Repositories.discover = DiscoverRepositoryImpl(DiscoverService(http));
  Repositories.match = MatchRepositoryImpl(
    FirestoreMatchService(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
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
