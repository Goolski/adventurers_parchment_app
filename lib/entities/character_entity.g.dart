// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterEntity _$CharacterEntityFromJson(Map<String, dynamic> json) =>
    CharacterEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      characterClasses: (json['characterClasses'] as List<dynamic>)
          .map((e) => CharacterClassEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      spellIds:
          (json['spellIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CharacterEntityToJson(CharacterEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'characterClasses': instance.characterClasses,
      'spellIds': instance.spellIds,
    };
