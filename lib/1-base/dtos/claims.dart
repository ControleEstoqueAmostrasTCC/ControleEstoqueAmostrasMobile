import 'package:json_annotation/json_annotation.dart';

part 'claims.g.dart';

@JsonSerializable()
class Claims {
  int? id;
  String? roleId;
  String claimType;
  String claimValue;

  Claims({this.id, this.roleId, required this.claimType, required this.claimValue});

  factory Claims.fromJson(Map<String, dynamic> json) => _$ClaimsFromJson(json);
}
