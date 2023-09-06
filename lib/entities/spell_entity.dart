import 'package:json_annotation/json_annotation.dart';

part 'spell_entity.g.dart';

@JsonSerializable()
class SpellEntity {
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
}
