// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Claims _$ClaimsFromJson(Map<String, dynamic> json) => Claims(
      issuer: json['issuer'] as String?,
      originalIssuer: json['originalIssuer'] as String?,
      type: json['type'] as String?,
      value: json['value'] as String?,
      valueType: json['valueType'] as String?,
    );

Map<String, dynamic> _$ClaimsToJson(Claims instance) => <String, dynamic>{
      'issuer': instance.issuer,
      'originalIssuer': instance.originalIssuer,
      'type': instance.type,
      'value': instance.value,
      'valueType': instance.valueType,
    };
