import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/data/repositories_implementation/categories_repository_impl.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/movie.dart';
import 'package:portafolio/app/domain/typedefs.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockCategoriesService service;
  late CategoriesRepositoryImpl repository;

  setUp(() {
    service = MockCategoriesService();
    repository = CategoriesRepositoryImpl(service);
  });

  test('getMovies devuelve la página en caso de éxito', () async {
    when(service.getMovies(any, page: anyNamed('page'))).thenAnswer(
      (_) async => const Right<HttpFailure, MoviesPage>(
        (movies: [Movie(id: 1, title: 'A')], page: 2, totalPages: 9),
      ),
    );

    final result = await repository.getMovies(
      MovieCategory.nowPlaying,
      page: 2,
    );

    expect(result.isRight, isTrue);
    result.when(
      (_) => fail('no debería fallar'),
      (data) {
        expect(data.movies.first.title, 'A');
        expect(data.page, 2);
        expect(data.totalPages, 9);
      },
    );
  });

  test('getMovies traduce el fallo a HttpFailureType', () async {
    when(service.getMovies(any, page: anyNamed('page'))).thenAnswer(
      (_) async => Left<HttpFailure, MoviesPage>(
        HttpFailure(type: HttpFailureType.server),
      ),
    );

    final result = await repository.getMovies(MovieCategory.topRated);

    expect(result.isLeft, isTrue);
    result.when(
      (failure) => expect(failure, HttpFailureType.server),
      (_) => fail('no debería tener éxito'),
    );
  });
}
