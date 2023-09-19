import 'package:controle_estoque_amostras_app/1-base/dtos/claims.dart';
import 'package:controle_estoque_amostras_app/1-base/dtos/user_claims.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_claims_dto.g.dart';

@JsonSerializable()
class UserClaimsDTO {
  List<Claims>? claims;
  List<UserClaims>? userClaims;

  UserClaimsDTO({this.claims, this.userClaims});

  factory UserClaimsDTO.fromJson(Map<String, dynamic> json) => _$UserClaimsDTOFromJson(json);
}
