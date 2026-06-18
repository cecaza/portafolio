import 'package:freezed_annotation/freezed_annotation.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

/// Género de la persona. TheMovieDB lo manda como número en el JSON;
/// `@JsonValue` mapea cada número al valor del enum (lectura 338).
enum Gender {
  @JsonValue(0)
  unknown,
  @JsonValue(1)
  female,
  @JsonValue(2)
  male,
  @JsonValue(3)
  nonBinary,
}

/// Una persona popular de TheMovieDB (actor, director, etc.).
@freezed
abstract class Performer with _$Performer {
  const factory Performer({
    required int id,
    @Default('') String name,
    @JsonKey(name: 'profile_path') String? profilePath,
    @Default(Gender.unknown) Gender gender,
    @JsonKey(name: 'known_for_department') String? department,
    // Películas/series por las que es conocida la persona.
    @JsonKey(name: 'known_for') @Default(<KnownFor>[]) List<KnownFor> knownFor,
  }) = _Performer;

  factory Performer.fromJson(Map<String, dynamic> json) =>
      _$PerformerFromJson(json);
}

/// Un título (película o serie) por el que una persona es conocida.
@freezed
abstract class KnownFor with _$KnownFor {
  const factory KnownFor({
    required int id,
    @JsonKey(name: 'poster_path') String? posterPath,
    // En películas el título viene en 'title'; en series, en 'name'.
    @JsonKey(name: 'title', readValue: _readTitle) @Default('') String title,
  }) = _KnownFor;

  factory KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForFromJson(json);
}

Object? _readTitle(Map<dynamic, dynamic> json, String key) {
  return json['title'] ?? json['name'] ?? '';
}
