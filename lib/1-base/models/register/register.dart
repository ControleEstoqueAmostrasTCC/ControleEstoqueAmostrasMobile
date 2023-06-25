import 'package:controle_estoque_amostras_app/1-base/models/base/base_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/models/box/box.dart';
import 'package:controle_estoque_amostras_app/1-base/models/collectionLocation/collection_location.dart';
import 'package:controle_estoque_amostras_app/1-base/models/gender/gender.dart';
import 'package:controle_estoque_amostras_app/1-base/models/procedure/procedure.dart';
import 'package:controle_estoque_amostras_app/1-base/models/specie/specie.dart';
import 'package:controle_estoque_amostras_app/1-base/models/tissue/tissue.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class Register extends BaseEntity {
  final int number;
  String? freezer;
  String? cytogenetic;
  DateTime? collectionDate;
  String? observation;
  int? verticalPosition;
  int? horizontalPosition;
  String? boxId;
  @JsonKey(includeToJson: false)
  Box? box;
  String? genderId;
  @JsonKey(includeToJson: false)
  Gender? gender;
  String? collectionLocationId;
  @JsonKey(includeToJson: false)
  CollectionLocation? collectionLocation;
  String? procedureId;
  @JsonKey(includeToJson: false)
  Procedure? procedure;
  String? specieId;
  @JsonKey(includeToJson: false)
  Specie? specie;
  String? tissueId;
  @JsonKey(includeToJson: false)
  Tissue? tissue;
  String? responsibleUserId;
  @JsonKey(includeToJson: false)
  User? responsibleUser;

  Register({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required this.number,
    this.freezer,
    this.cytogenetic,
    this.collectionDate,
    this.observation,
    this.verticalPosition,
    this.horizontalPosition,
    this.boxId,
    this.genderId,
    this.collectionLocationId,
    this.procedureId,
    this.specieId,
    this.tissueId,
    this.responsibleUserId,
  });

  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
