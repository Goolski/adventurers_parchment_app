// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpellEntity _$SpellEntityFromJson(Map<String, dynamic> json) => SpellEntity(
      index: json['index'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$SpellEntityToJson(SpellEntity instance) =>
    <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'url': instance.url,
    };

SpellEntityWithDetails _$SpellEntityWithDetailsFromJson(
        Map<String, dynamic> json) =>
    SpellEntityWithDetails(
      range: json['range'] as String,
      desc: (json['desc'] as List<dynamic>).map((e) => e as String).toList(),
      components: (json['components'] as List<dynamic>)
          .map((e) => $enumDecode(_$SpellComponentEnumMap, e))
          .toSet(),
      level: json['level'] as int,
      duration: json['duration'] as String,
      index: json['index'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      castingTime: json['casting_time'] as String,
      concentration: json['concentration'] as bool,
      school: SchoolEntity.fromJson(json['school'] as Map<String, dynamic>),
      characterClass: (json['classes'] as List<dynamic>)
          .map((e) => CharacterClassEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpellEntityWithDetailsToJson(
        SpellEntityWithDetails instance) =>
    <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'url': instance.url,
      'range': instance.range,
      'desc': instance.desc,
      'components':
          instance.components.map((e) => _$SpellComponentEnumMap[e]!).toList(),
      'level': instance.level,
      'duration': instance.duration,
      'casting_time': instance.castingTime,
      'concentration': instance.concentration,
      'school': instance.school,
      'classes': instance.characterClass,
    };

const _$SpellComponentEnumMap = {
  SpellComponent.verbal: 'V',
  SpellComponent.somatic: 'S',
  SpellComponent.material: 'M',
};
