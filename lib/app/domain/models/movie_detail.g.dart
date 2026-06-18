// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) => _MovieDetail(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      backdropPath: json['backdrop_path'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] as String?,
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Genre>[],
      cast: (_readCast(json, 'credits') as List<dynamic>?)
              ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Cast>[],
      isFavorite: _readFavorite(json, 'account_states') as bool? ?? false,
    );

Map<String, dynamic> _$MovieDetailToJson(_MovieDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'tagline': instance.tagline,
      'backdrop_path': instance.backdropPath,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'credits': instance.cast,
      'account_states': instance.isFavorite,
    };

_Cast _$CastFromJson(Map<String, dynamic> json) => _Cast(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      character: json['character'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$CastToJson(_Cast instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'character': instance.character,
      'profile_path': instance.profilePath,
    };

_Genre _$GenreFromJson(Map<String, dynamic> json) => _Genre(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$GenreToJson(_Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
