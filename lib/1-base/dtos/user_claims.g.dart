// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_claims.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserClaims _$UserClaimsFromJson(Map<String, dynamic> json) => UserClaims(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      claimType: json['claimType'] as String,
      claimValue: json['claimValue'] as String,
    );

Map<String, dynamic> _$UserClaimsToJson(UserClaims instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'claimType': instance.claimType,
      'claimValue': instance.claimValue,
    };
