import 'package:go_router/go_router.dart';

import '../../domain/enums.dart';
import '../global/widgets/scaffold_with_nav_bar.dart';
import '../modules/category/views/category_view.dart';
import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/match/views/match_view.dart';
import '../modules/movie/views/movie_detail_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/person/views/person_detail_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

/// Configuración de navegación con go_router (Navigator 2.0).
///
/// Las 4 pestañas principales viven dentro de un [StatefulShellRoute] con
/// barra inferior (cada una conserva su estado). El splash, login, offline y
/// el detalle de película van a pantalla completa (fuera del shell).
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(path: Routes.splash, builder: (_, __) => const SplashView()),
      GoRoute(path: Routes.signIn, builder: (_, __) => const SignInView()),
      GoRoute(path: Routes.offline, builder: (_, __) => const OfflineView()),
      GoRoute(
        // El id de la película viaja en la URL: /movie/123
        path: '${Routes.movie}/:id',
        builder: (_, state) => MovieDetailView(
          movieId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        // El id de la persona viaja en la URL: /person/123
        path: '${Routes.person}/:id',
        builder: (_, state) => PersonDetailView(
          personId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        // La categoría viaja en la URL: /category/now_playing
        path: '${Routes.category}/:category',
        builder: (_, state) => CategoryView(
          category: MovieCategory.values.firstWhere(
            (c) => c.path == state.pathParameters['category'],
            orElse: () => MovieCategory.popular,
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: Routes.home, builder: (_, __) => const HomeView()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.search,
                builder: (_, __) => const SearchView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.favorites,
                builder: (_, __) => const FavoritesView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.match,
                builder: (_, __) => const MatchView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (_, __) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Instancia global usada por la app.
final appRouter = createAppRouter();
