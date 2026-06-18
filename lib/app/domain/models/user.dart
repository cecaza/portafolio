import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Datos de la cuenta del usuario autenticado en TheMovieDB.
///
/// Modelo INMUTABLE generado con freezed: copyWith, ==, hashCode, toString
/// y fromJson/toJson se generan solos (ver user.freezed.dart / user.g.dart).
@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String name,
    required String username,
    @JsonKey(name: 'include_adult') @Default(false) bool includeAdult,
    @JsonKey(name: 'iso_639_1') String? language,
    @JsonKey(name: 'iso_3166_1') String? country,
    // El avatar viene anidado en json['avatar']['tmdb']['avatar_path'];
    // readValue lo "aplana" hacia este campo.
    @JsonKey(name: 'avatar', readValue: _readAvatarPath) String? avatarPath,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

Object? _readAvatarPath(Map<dynamic, dynamic> json, String key) {
  final avatar = json['avatar'] as Map<dynamic, dynamic>?;
  final tmdb = avatar?['tmdb'] as Map<dynamic, dynamic>?;
  return tmdb?['avatar_path'];
}
