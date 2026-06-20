import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../domain/typedefs.dart';
import '../services/remote/categories_service.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl(this._categoriesService);

  final CategoriesService _categoriesService;

  @override
  Future<Either<HttpFailureType, MoviesPage>> getMovies(
    MovieCategory category, {
    int page = 1,
  }) async {
    final result = await _categoriesService.getMovies(category, page: page);
    // Traducimos el fallo técnico (data) a un fallo del dominio.
    return result.when(
      (failure) => Left(failure.type),
      (moviesPage) => Right(moviesPage),
    );
  }
}
