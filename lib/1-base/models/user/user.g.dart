// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      active: fromJsonBoolean(json['active']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      code: json['code'] as int?,
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      claims: (json['claims'] as List<dynamic>?)
          ?.map((e) => Claims.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'code': instance.code,
      'userId': instance.userId,
      'description': instance.description,
      'name': instance.name,
      'claims': instance.claims,
      'token': instance.token,
    };
