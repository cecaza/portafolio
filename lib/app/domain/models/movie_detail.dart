import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';
part 'movie_detail.g.dart';

/// Detalle completo de una película de TheMovieDB.
@freezed
abstract class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required int id,
    @Default('') String title,
    @Default('') String overview,
    @Default('') String tagline,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'release_date') String? releaseDate,
    @Default(0) int runtime,
    @Default(0) int budget,
    @Default(0) int revenue,
    @Default(<Genre>[]) List<Genre> genres,
    // El reparto viene anidado en credits.cast (append_to_response=credits).
    @JsonKey(name: 'credits', readValue: _readCast)
    @Default(<Cast>[])
    List<Cast> cast,
    // ¿Es favorita? Viene en account_states.favorite (si hay sesión).
    @JsonKey(name: 'account_states', readValue: _readFavorite)
    @Default(false)
    bool isFavorite,
  }) = _MovieDetail;

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);
}

Object? _readCast(Map<dynamic, dynamic> json, String key) {
  final credits = json['credits'] as Map<dynamic, dynamic>?;
  return credits?['cast'] ?? const [];
}

Object? _readFavorite(Map<dynamic, dynamic> json, String key) {
  final states = json['account_states'] as Map<dynamic, dynamic>?;
  return states?['favorite'] ?? false;
}

/// Un miembro del reparto de una película.
@freezed
abstract class Cast with _$Cast {
  const factory Cast({
    required int id,
    @Default('') String name,
    @Default('') String character,
    @JsonKey(name: 'profile_path') String? profilePath,
  }) = _Cast;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}

/// Género de una película (acción, drama, etc.).
@freezed
abstract class Genre with _$Genre {
  const factory Genre({
    required int id,
    @Default('') String name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
