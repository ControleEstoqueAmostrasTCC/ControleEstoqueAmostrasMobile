import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'box.g.dart';

@JsonSerializable()
class Box extends BaseDescriptionEntity {
  final int horizontalSize;
  final int verticalSize;

  Box({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required super.description,
    required this.horizontalSize,
    required this.verticalSize,
  });

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);

  Map<String, dynamic> toJson() => _$BoxToJson(this);
}
