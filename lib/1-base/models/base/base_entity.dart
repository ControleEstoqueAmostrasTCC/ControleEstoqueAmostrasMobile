import 'package:controle_estoque_amostras_app/2-base/utils/mappers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_entity.g.dart';

@JsonSerializable()
class BaseEntity {
  final String id;
  @JsonKey(fromJson: fromJsonBoolean)
  bool active;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? code;
  final String? userId;

  BaseEntity({
    required this.id,
    required this.active,
    required this.createdAt,
    this.updatedAt,
    this.code,
    this.userId,
  });

  factory BaseEntity.fromJson(Map<String, dynamic> json) => _$BaseEntityFromJson(json);
}
