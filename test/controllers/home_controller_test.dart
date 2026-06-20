import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/movie.dart';
import 'package:portafolio/app/domain/models/performer.dart';
import 'package:portafolio/app/domain/typedefs.dart';
import 'package:portafolio/app/presentation/modules/home/controller/home_controller.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockTrendingRepository trending;
  late MockPerformersRepository performers;
  late MockCategoriesRepository categories;
  late HomeController controller;

  setUp(() {
    trending = MockTrendingRepository();
    performers = MockPerformersRepository();
    categories = MockCategoriesRepository();
    controller = HomeController(trending, performers, categories);
  });

  test('init carga películas, personas y secciones correctamente', () async {
    when(trending.getMovies(any)).thenAnswer(
      (_) async => const Right<HttpFailureType, List<Movie>>(
        [Movie(id: 1, title: 'A')],
      ),
    );
    when(performers.getPerformers(any)).thenAnswer(
      (_) async => const Right<HttpFailureType, List<Performer>>(
        [Performer(id: 1, name: 'Actor')],
      ),
    );
    when(categories.getMovies(any, page: anyNamed('page'))).thenAnswer(
      (_) async => const Right<HttpFailureType, MoviesPage>(
        (movies: [Movie(id: 2, title: 'B')], page: 1, totalPages: 5),
      ),
    );

    await controller.init();

    expect(controller.state.moviesLoading, isFalse);
    expect(controller.state.performersLoading, isFalse);
    expect(controller.state.sectionsLoading, isFalse);
    expect(controller.state.movies.length, 1);
    expect(controller.state.performers.length, 1);
    expect(controller.state.sections.isNotEmpty, isTrue);
    expect(controller.state.moviesFailed, isFalse);
    expect(controller.state.performersFailed, isFalse);
    expect(controller.state.sectionsFailed, isFalse);
  });

  test('init marca los flags de fallo cuando falla', () async {
    when(trending.getMovies(any)).thenAnswer(
      (_) async =>
          const Left<HttpFailureType, List<Movie>>(HttpFailureType.server),
    );
    when(performers.getPerformers(any)).thenAnswer(
      (_) async =>
          const Left<HttpFailureType, List<Performer>>(HttpFailureType.server),
    );
    when(categories.getMovies(any, page: anyNamed('page'))).thenAnswer(
      (_) async =>
          const Left<HttpFailureType, MoviesPage>(HttpFailureType.server),
    );

    await controller.init();

    expect(controller.state.moviesFailed, isTrue);
    expect(controller.state.performersFailed, isTrue);
    expect(controller.state.sectionsFailed, isTrue);
    expect(controller.state.movies, isEmpty);
  });
}
