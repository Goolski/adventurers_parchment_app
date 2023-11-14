import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_class_entity.g.dart';

@JsonSerializable()
class CharacterClassEntity extends Equatable {
  const CharacterClassEntity({
    required this.index,
    required this.name,
    required this.url,
  });

  final String index;
  final String name;
  final String url;

  Map<String, dynamic> toJson() => _$CharacterClassEntityToJson(this);

  factory CharacterClassEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterClassEntityFromJson(json);

  @override
  List<Object?> get props => [index];
}

const names = [
  'Barbarian',
  'Bard',
  'Cleric',
  'Druid',
  'Fighter',
  'Monk',
  'Paladin',
  'Ranger',
  'Rogue',
  'Sorcerer',
  'Warlock',
  'Wizard'
];
final indexes = names.map((e) => e.toLowerCase()).toList();
final urls = indexes.map((e) => '/api/classes/$e').toList();
final defaultListOfCharacterClasses = List.generate(
  names.length,
  (index) => CharacterClassEntity(
    index: indexes[index],
    name: names[index],
    url: urls[index],
  ),
).toList();
