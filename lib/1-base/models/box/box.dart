import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/mappers.dart';
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
    this.horizontalSize = 0,
    this.verticalSize = 0,
  });

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoxToJson(this);
}
