import '../enums.dart';

/// Criterios para descubrir películas con `/discover/movie` de TheMovieDB.
///
/// Se usa para alimentar el deck de swipe cuando la pareja no sabe qué ver:
/// eligen uno o varios géneros (y opcionalmente una nota mínima) y la app
/// trae sugerencias paginadas.
class DiscoverFilter {
  const DiscoverFilter({
    this.genres = const {},
    this.minVoteAverage,
  });

  /// Géneros seleccionados. Vacío = cualquier género.
  final Set<MovieGenre> genres;

  /// Nota mínima (0–10) para filtrar; `null` = sin filtro de nota.
  final double? minVoteAverage;

  /// `with_genres` para TMDB. Usamos `|` (OR): trae pelis de CUALQUIERA de los
  /// géneros elegidos (ej. aventura O fantasía), no solo las que son de todos
  /// a la vez (eso sería con coma `,` = AND).
  String get genresParam => genres.map((g) => g.id).join('|');

  bool get isEmpty => genres.isEmpty && minVoteAverage == null;

  DiscoverFilter copyWith({
    Set<MovieGenre>? genres,
    double? minVoteAverage,
  }) {
    return DiscoverFilter(
      genres: genres ?? this.genres,
      minVoteAverage: minVoteAverage ?? this.minVoteAverage,
    );
  }
}
