import 'package:adventurers_parchment/entities/character_class_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'character_entity.g.dart';

@JsonSerializable()
class CharacterEntity {
  final String id;
  final String name;
  final List<CharacterClassEntity> characterClasses;
  final List<String> spellIds;

  CharacterEntity(
      {required this.id,
      required this.name,
      required this.characterClasses,
      required this.spellIds});

  factory CharacterEntity.empty({
    required String characterName,
    List<CharacterClassEntity>? characterClasses,
  }) {
    final uuid = Uuid();
    return CharacterEntity(
      id: uuid.v4(),
      name: characterName,
      characterClasses: characterClasses ?? [],
      spellIds: [],
    );
  }

  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);

  factory CharacterEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterEntityFromJson(json);
  CharacterEntity copyWith(
      {String? id,
      String? name,
      List<CharacterClassEntity>? characterClasses,
      List<String>? spellIds}) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      characterClasses: characterClasses ?? this.characterClasses,
      spellIds: spellIds ?? this.spellIds,
    );
  }
}
