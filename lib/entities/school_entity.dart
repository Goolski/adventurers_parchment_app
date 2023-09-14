import 'package:json_annotation/json_annotation.dart';

part 'school_entity.g.dart';

@JsonSerializable()
class SchoolEntity {
  SchoolEntity({
    required this.index,
    required this.name,
    required this.url,
  });

  final String index;
  final String name;
  final String url;

  Map<String, dynamic> toJson() => _$SchoolEntityToJson(this);

  factory SchoolEntity.fromJson(Map<String, dynamic> json) =>
      _$SchoolEntityFromJson(json);

  @override
  List<Object?> get props => [index];
}
