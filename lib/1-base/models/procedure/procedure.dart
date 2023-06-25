import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'procedure.g.dart';

@JsonSerializable()
class Procedure extends BaseDescriptionEntity {
  Procedure({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required super.description,
  });

  factory Procedure.fromJson(Map<String, dynamic> json) => _$ProcedureFromJson(json);

  Map<String, dynamic> toJson() => _$ProcedureToJson(this);
}
