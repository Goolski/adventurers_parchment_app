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

@JsonSerializable()
class SpellEntityWithDetails extends SpellEntity {
  final String range;
  final List<String> desc;
  final Set<SpellComponent> components;
  final int level;
  final String duration;

  SpellEntityWithDetails({
    required this.range,
    required this.desc,
    required this.components,
    required this.level,
    required this.duration,
    required super.index,
    required super.name,
    required super.url,
  });

  factory SpellEntityWithDetails.fromJson(Map<String, dynamic> json) =>
      _$SpellEntityWithDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpellEntityWithDetailsToJson(this);
}

enum SpellComponent {
  @JsonValue('V')
  verbal,
  @JsonValue('S')
  somatic,
  @JsonValue('M')
  material,
}
