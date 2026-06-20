import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portafolio/app/data/http/http.dart';
import 'package:portafolio/app/data/repositories_implementation/trending_repository_impl.dart';
import 'package:portafolio/app/domain/either/either.dart';
import 'package:portafolio/app/domain/enums.dart';
import 'package:portafolio/app/domain/models/movie.dart';

import '../mocks/dummies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  registerDummies();
  late MockTrendingService service;
  late TrendingRepositoryImpl repository;

  setUp(() {
    service = MockTrendingService();
    repository = TrendingRepositoryImpl(service);
  });

  test('getMovies devuelve la lista en caso de éxito', () async {
    when(service.getMovies(any)).thenAnswer(
      (_) async =>
          const Right<HttpFailure, List<Movie>>([Movie(id: 1, title: 'A')]),
    );

    final result = await repository.getMovies(TimeWindow.day);

    expect(result.isRight, isTrue);
    result.when((_) => fail('no debería fallar'),
        (movies) => expect(movies.first.title, 'A'));
  });

  test('getMovies traduce el fallo a HttpFailureType', () async {
    when(service.getMovies(any)).thenAnswer(
      (_) async => Left<HttpFailure, List<Movie>>(
        HttpFailure(type: HttpFailureType.server),
      ),
    );

    final result = await repository.getMovies(TimeWindow.week);

    expect(result.isLeft, isTrue);
    result.when((failure) => expect(failure, HttpFailureType.server),
        (_) => fail('no debería tener éxito'));
  });
}
