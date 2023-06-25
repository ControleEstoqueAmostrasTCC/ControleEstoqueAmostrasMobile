import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tissue.g.dart';

@JsonSerializable()
class Tissue extends BaseDescriptionEntity {
  Tissue({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required super.description,
  });

  factory Tissue.fromJson(Map<String, dynamic> json) => _$TissueFromJson(json);

  Map<String, dynamic> toJson() => _$TissueToJson(this);
}
