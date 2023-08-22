import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/mappers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specie.g.dart';

@JsonSerializable()
class Specie extends BaseDescriptionEntity {
  Specie({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required super.description,
  });

  factory Specie.fromJson(Map<String, dynamic> json) => _$SpecieFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpecieToJson(this);
}
