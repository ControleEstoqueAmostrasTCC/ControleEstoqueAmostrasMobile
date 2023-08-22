import 'package:controle_estoque_amostras_app/1-base/models/base/base_entity.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/mappers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_description_entity.g.dart';

@JsonSerializable()
class BaseDescriptionEntity extends BaseEntity {
  String? description;
  String? name;

  BaseDescriptionEntity({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    this.description,
    this.name,
  });

  factory BaseDescriptionEntity.fromJson(Map<String, dynamic> json) => _$BaseDescriptionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseDescriptionEntityToJson(this);
}
