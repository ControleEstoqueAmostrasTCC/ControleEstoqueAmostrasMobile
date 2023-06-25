import 'package:controle_estoque_amostras_app/1-base/models/base/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseEntity {
  final String name;
  User({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
