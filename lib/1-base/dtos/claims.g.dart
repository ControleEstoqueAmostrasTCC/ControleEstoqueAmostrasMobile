// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Claims _$ClaimsFromJson(Map<String, dynamic> json) => Claims(
      id: json['id'] as int?,
      roleId: json['roleId'] as String?,
      claimType: json['claimType'] as String,
      claimValue: json['claimValue'] as String,
    );

Map<String, dynamic> _$ClaimsToJson(Claims instance) => <String, dynamic>{
      'id': instance.id,
      'roleId': instance.roleId,
      'claimType': instance.claimType,
      'claimValue': instance.claimValue,
    };
