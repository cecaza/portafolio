// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonDetail _$PersonDetailFromJson(Map<String, dynamic> json) =>
    _PersonDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      biography: json['biography'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
      department: json['known_for_department'] as String?,
      birthday: json['birthday'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      movies: (_readCast(json, 'movie_credits') as List<dynamic>?)
              ?.map((e) => PersonMovie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PersonMovie>[],
    );

Map<String, dynamic> _$PersonDetailToJson(_PersonDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'biography': instance.biography,
      'profile_path': instance.profilePath,
      'known_for_department': instance.department,
      'birthday': instance.birthday,
      'place_of_birth': instance.placeOfBirth,
      'movie_credits': instance.movies,
    };

_PersonMovie _$PersonMovieFromJson(Map<String, dynamic> json) => _PersonMovie(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] as String?,
      character: json['character'] as String? ?? '',
    );

Map<String, dynamic> _$PersonMovieToJson(_PersonMovie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
      'character': instance.character,
    };
