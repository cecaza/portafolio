// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      username: json['username'] as String,
      includeAdult: json['include_adult'] as bool? ?? false,
      language: json['iso_639_1'] as String?,
      country: json['iso_3166_1'] as String?,
      avatarPath: _readAvatarPath(json, 'avatar') as String?,
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'include_adult': instance.includeAdult,
      'iso_639_1': instance.language,
      'iso_3166_1': instance.country,
      'avatar': instance.avatarPath,
    };
