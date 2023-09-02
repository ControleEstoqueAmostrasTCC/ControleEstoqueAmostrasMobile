// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_claims_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserClaimsDTO _$UserClaimsDTOFromJson(Map<String, dynamic> json) =>
    UserClaimsDTO(
      claims: (json['claims'] as List<dynamic>?)
          ?.map((e) => Claims.fromJson(e as Map<String, dynamic>))
          .toList(),
      userClaims: (json['userClaims'] as List<dynamic>?)
          ?.map((e) => UserClaims.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserClaimsDTOToJson(UserClaimsDTO instance) =>
    <String, dynamic>{
      'claims': instance.claims,
      'userClaims': instance.userClaims,
    };
