import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_detail.freezed.dart';
part 'person_detail.g.dart';

/// Detalle de una persona (actor, director...) de TheMovieDB, con su
/// filmografía obtenida vía `append_to_response=movie_credits`.
@freezed
abstract class PersonDetail with _$PersonDetail {
  const factory PersonDetail({
    required int id,
    @Default('') String name,
    @Default('') String biography,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'known_for_department') String? department,
    String? birthday,
    @JsonKey(name: 'place_of_birth') String? placeOfBirth,
    // Filmografía: películas en las que ha participado (movie_credits.cast).
    @JsonKey(name: 'movie_credits', readValue: _readCast)
    @Default(<PersonMovie>[])
    List<PersonMovie> movies,
  }) = _PersonDetail;

  factory PersonDetail.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailFromJson(json);
}

/// Extrae el arreglo `cast` que viene anidado dentro de `movie_credits`.
Object? _readCast(Map<dynamic, dynamic> json, String key) {
  final credits = json['movie_credits'];
  if (credits is Map && credits['cast'] is List) {
    return credits['cast'];
  }
  return const [];
}

/// Una película dentro de la filmografía de una persona.
@freezed
abstract class PersonMovie with _$PersonMovie {
  const factory PersonMovie({
    required int id,
    @Default('') String title,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'vote_average') @Default(0.0) double voteAverage,
    @JsonKey(name: 'release_date') String? releaseDate,
    @Default('') String character,
  }) = _PersonMovie;

  factory PersonMovie.fromJson(Map<String, dynamic> json) =>
      _$PersonMovieFromJson(json);
}
