// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tissue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tissue _$TissueFromJson(Map<String, dynamic> json) => Tissue(
      id: json['id'] as String,
      active: fromJsonBoolean(json['active']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      code: json['code'] as int?,
      userId: json['userId'] as String?,
      description: json['description'] as String?,
    )..name = json['name'] as String?;

Map<String, dynamic> _$TissueToJson(Tissue instance) => <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'code': instance.code,
      'userId': instance.userId,
      'description': instance.description,
      'name': instance.name,
    };
