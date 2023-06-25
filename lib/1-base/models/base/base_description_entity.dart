import 'package:controle_estoque_amostras_app/1-base/models/base/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_description_entity.g.dart';

@JsonSerializable()
class BaseDescriptionEntity extends BaseEntity {
  final String description;

  BaseDescriptionEntity({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required this.description,
  });

  factory BaseDescriptionEntity.fromJson(Map<String, dynamic> json) => _$BaseDescriptionEntityFromJson(json);
}
