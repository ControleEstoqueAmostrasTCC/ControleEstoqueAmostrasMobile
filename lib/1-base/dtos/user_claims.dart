import 'package:json_annotation/json_annotation.dart';

part 'user_claims.g.dart';

@JsonSerializable()
class UserClaims {
  int? id;
  String? userId;
  String claimType;
  String claimValue;

  UserClaims({this.id, this.userId, required this.claimType, required this.claimValue});

  factory UserClaims.fromJson(Map<String, dynamic> json) => _$UserClaimsFromJson(json);
}
