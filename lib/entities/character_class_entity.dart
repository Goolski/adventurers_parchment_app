import 'package:json_annotation/json_annotation.dart';

part 'character_class_entity.g.dart';

@JsonSerializable()
class CharacterClassEntity {
  CharacterClassEntity({
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
