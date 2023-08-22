// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      id: json['id'] as String,
      active: fromJsonBoolean(json['active']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      code: json['code'] as int?,
      userId: json['userId'] as String?,
      number: json['number'] as int,
      freezer: json['freezer'] as String?,
      cytogenetic: json['cytogenetic'] as String?,
      collectionDate: json['collectionDate'] == null
          ? null
          : DateTime.parse(json['collectionDate'] as String),
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
      ..box = json['box'] == null
          ? null
          : Box.fromJson(json['box'] as Map<String, dynamic>)
      ..boxDescription = json['boxDescription'] as String?
      ..gender = json['gender'] == null
          ? null
          : Gender.fromJson(json['gender'] as Map<String, dynamic>)
      ..genderDescription = json['genderDescription'] as String?
      ..collectionLocation = json['collectionLocation'] == null
          ? null
          : CollectionLocation.fromJson(
              json['collectionLocation'] as Map<String, dynamic>)
      ..collectionLocationDescription =
          json['collectionLocationDescription'] as String?
      ..procedure = json['procedure'] == null
          ? null
          : Procedure.fromJson(json['procedure'] as Map<String, dynamic>)
      ..procedureDescription = json['procedureDescription'] as String?
      ..specie = json['specie'] == null
          ? null
          : Specie.fromJson(json['specie'] as Map<String, dynamic>)
      ..specieDescription = json['specieDescription'] as String?
      ..tissue = json['tissue'] == null
          ? null
          : Tissue.fromJson(json['tissue'] as Map<String, dynamic>)
      ..tissueDescription = json['tissueDescription'] as String?
      ..responsibleUser = json['responsibleUser'] == null
          ? null
          : User.fromJson(json['responsibleUser'] as Map<String, dynamic>)
      ..responsibleUserName = json['responsibleUserName'] as String?;

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
      'boxDescription': instance.boxDescription,
      'genderId': instance.genderId,
      'genderDescription': instance.genderDescription,
      'collectionLocationId': instance.collectionLocationId,
      'collectionLocationDescription': instance.collectionLocationDescription,
      'procedureId': instance.procedureId,
      'procedureDescription': instance.procedureDescription,
      'specieId': instance.specieId,
      'specieDescription': instance.specieDescription,
      'tissueId': instance.tissueId,
      'tissueDescription': instance.tissueDescription,
      'responsibleUserId': instance.responsibleUserId,
      'responsibleUserName': instance.responsibleUserName,
    };
