// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_acess_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAcessDTO _$PostAcessDTOFromJson(Map<String, dynamic> json) => PostAcessDTO(
      claimType: json['claimType'] as String,
      claimValue: json['claimValue'] as String,
      isSelected: json['isSelected'] as bool,
    );

Map<String, dynamic> _$PostAcessDTOToJson(PostAcessDTO instance) =>
    <String, dynamic>{
      'claimType': instance.claimType,
      'claimValue': instance.claimValue,
      'isSelected': instance.isSelected,
    };
