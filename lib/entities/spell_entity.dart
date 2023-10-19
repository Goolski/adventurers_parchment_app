import 'package:adventurers_parchment/entities/character_class_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'school_entity.dart';

part 'spell_entity.g.dart';

@JsonSerializable()
class SpellEntity extends Equatable {
  final String index;
  final String name;
  final String url;

  SpellEntity({
    required this.index,
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toJson() => _$SpellEntityToJson(this);

  factory SpellEntity.fromJson(Map<String, dynamic> json) =>
      _$SpellEntityFromJson(json);

  @override
  List<Object?> get props => [index];
}

@JsonSerializable()
class SpellEntityWithDetails extends SpellEntity {
  final String range;
  final List<String> desc;
  final Set<SpellComponent> components;
  final int level;
  final String duration;
  @JsonKey(name: 'casting_time')
  final String castingTime;
  final bool concentration;
  @JsonKey(name: 'school')
  final SchoolEntity school;
  @JsonKey(name: 'classes')
  final List<CharacterClassEntity> characterClasses;
  final bool ritual;

  SpellEntityWithDetails({
    required this.range,
    required this.desc,
    required this.components,
    required this.level,
    required this.duration,
    required super.index,
    required super.name,
    required super.url,
    required this.castingTime,
    required this.concentration,
    required this.school,
    required this.characterClasses,
    required this.ritual,
  });

  factory SpellEntityWithDetails.fromJson(Map<String, dynamic> json) =>
      _$SpellEntityWithDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpellEntityWithDetailsToJson(this);

  static Map<int, List<SpellEntityWithDetails>> splitSpellsByLevel(
      List<SpellEntityWithDetails> spells) {
    var map = Map<int, List<SpellEntityWithDetails>>();
    var allLevels = spells.map((spell) => spell.level).toSet().toList();
    allLevels.sort();
    allLevels.forEach((level) {
      map[level] = [];
    });
    for (final spell in spells) {
      map[spell.level]!.add(spell);
    }
    return map;
  }
}

enum SpellComponent {
  @JsonValue('V')
  verbal,
  @JsonValue('S')
  somatic,
  @JsonValue('M')
  material,
}

extension SpellComponentToString on SpellComponent {
  String getString() {
    switch (this) {
      case SpellComponent.verbal:
        return 'Verbal';
      case SpellComponent.somatic:
        return 'Somatic';
      case SpellComponent.material:
        return 'Material';
    }
  }
}

enum SpellLevel {
  cantrip,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine
}
