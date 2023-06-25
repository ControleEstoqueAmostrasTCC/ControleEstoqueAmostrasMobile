// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      id: json['id'] as String,
      active: json['active'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
      code: json['code'] as int?,
      userId: json['userId'] as String?,
      number: json['number'] as int,
      freezer: json['freezer'] as String?,
      cytogenetic: json['cytogenetic'] as String?,
      collectionDate: json['collectionDate'] == null ? null : DateTime.parse(json['collectionDate'] as String),
      observation: json['observation'] as String?,
      verticalPosition: json['verticalPosition'] as int?,
      horizontalPosition: json['horizontalPosition'] as int?,
      boxId: json['boxId'] as String?,
      genderId: json['genderId'] as String?,
      collectionLocationId: json['collectionLocationId'] as String?,
      procedureId: json['procedureId'] as String?,
      specieId: json['specieId'] as String?,
      tissueId: json['tissueId'] as String?,
      responsibleUserId: json['responsibleUserId'] as String?,
    )
      ..box = json['box'] == null ? null : Box.fromJson(json['box'] as Map<String, dynamic>)
      ..gender = json['gender'] == null ? null : Gender.fromJson(json['gender'] as Map<String, dynamic>)
      ..collectionLocation = json['collectionLocation'] == null
          ? null
          : CollectionLocation.fromJson(json['collectionLocation'] as Map<String, dynamic>)
      ..procedure = json['procedure'] == null ? null : Procedure.fromJson(json['procedure'] as Map<String, dynamic>)
      ..specie = json['specie'] == null ? null : Specie.fromJson(json['specie'] as Map<String, dynamic>)
      ..tissue = json['tissue'] == null ? null : Tissue.fromJson(json['tissue'] as Map<String, dynamic>)
      ..responsibleUser =
          json['responsibleUser'] == null ? null : User.fromJson(json['responsibleUser'] as Map<String, dynamic>);

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'code': instance.code,
      'userId': instance.userId,
      'number': instance.number,
      'freezer': instance.freezer,
      'cytogenetic': instance.cytogenetic,
      'collectionDate': instance.collectionDate?.toIso8601String(),
      'observation': instance.observation,
      'verticalPosition': instance.verticalPosition,
      'horizontalPosition': instance.horizontalPosition,
      'boxId': instance.boxId,
      'genderId': instance.genderId,
      'collectionLocationId': instance.collectionLocationId,
      'procedureId': instance.procedureId,
      'specieId': instance.specieId,
      'tissueId': instance.tissueId,
      'responsibleUserId': instance.responsibleUserId,
    };
