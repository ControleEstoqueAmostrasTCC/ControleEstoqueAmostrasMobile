import 'package:json_annotation/json_annotation.dart';

part 'post_acess_dto.g.dart';

@JsonSerializable()
class PostAcessDTO {
  final String claimType;
  final String claimValue;
  final bool isSelected;
  PostAcessDTO({
    required this.claimType,
    required this.claimValue,
    required this.isSelected,
  });

  factory PostAcessDTO.fromJson(Map<String, dynamic> json) => _$PostAcessDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PostAcessDTOToJson(this);
}
