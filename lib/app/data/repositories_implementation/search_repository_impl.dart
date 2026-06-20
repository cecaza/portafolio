import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/movie.dart';
import '../../domain/repositories/search_repository.dart';
import '../services/remote/search_service.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this._searchService);

  final SearchService _searchService;

  @override
  Future<Either<HttpFailureType, List<Movie>>> searchMovies(
    String query, {
    int page = 1,
  }) async {
    final result = await _searchService.searchMovies(query, page: page);
    return result.when(
      (failure) => Left(failure.type),
      (movies) => Right(movies),
    );
  }
}
