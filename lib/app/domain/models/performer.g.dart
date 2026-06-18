// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Performer _$PerformerFromJson(Map<String, dynamic> json) => _Performer(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']) ??
          Gender.unknown,
      department: json['known_for_department'] as String?,
      knownFor: (json['known_for'] as List<dynamic>?)
              ?.map((e) => KnownFor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <KnownFor>[],
    );

Map<String, dynamic> _$PerformerToJson(_Performer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'gender': _$GenderEnumMap[instance.gender]!,
      'known_for_department': instance.department,
      'known_for': instance.knownFor,
    };

const _$GenderEnumMap = {
  Gender.unknown: 0,
  Gender.female: 1,
  Gender.male: 2,
  Gender.nonBinary: 3,
};

_KnownFor _$KnownForFromJson(Map<String, dynamic> json) => _KnownFor(
      id: (json['id'] as num).toInt(),
      posterPath: json['poster_path'] as String?,
      title: _readTitle(json, 'title') as String? ?? '',
    );

Map<String, dynamic> _$KnownForToJson(_KnownFor instance) => <String, dynamic>{
      'id': instance.id,
      'poster_path': instance.posterPath,
      'title': instance.title,
    };
