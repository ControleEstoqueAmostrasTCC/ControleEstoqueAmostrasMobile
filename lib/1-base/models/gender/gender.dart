import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/mappers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gender.g.dart';

@JsonSerializable()
class Gender extends BaseDescriptionEntity {
  Gender({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required super.description,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GenderToJson(this);
}
