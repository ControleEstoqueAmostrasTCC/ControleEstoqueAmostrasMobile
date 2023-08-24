import 'package:controle_estoque_amostras_app/1-base/models/base/base_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/models/box/box.dart';
import 'package:controle_estoque_amostras_app/1-base/models/collectionLocation/collection_location.dart';
import 'package:controle_estoque_amostras_app/1-base/models/gender/gender.dart';
import 'package:controle_estoque_amostras_app/1-base/models/procedure/procedure.dart';
import 'package:controle_estoque_amostras_app/1-base/models/specie/specie.dart';
import 'package:controle_estoque_amostras_app/1-base/models/tissue/tissue.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/mappers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class Register extends BaseEntity {
  final int number;
  String? freezer;
  String? cytogenetic;
  @JsonKey(fromJson: fromJsonBoolean)
  late bool hasCytogenetic;
  DateTime? collectionDate;
  String? observation;
  int? verticalPosition;
  int? horizontalPosition;
  String? boxId;
  @JsonKey(includeToJson: false, includeIfNull: false)
  Box? box;
  String? boxDescription;
  String? genderId;
  @JsonKey(includeToJson: false, includeIfNull: false)
  Gender? gender;
  String? genderDescription;
  String? collectionLocationId;
  @JsonKey(includeToJson: false, includeIfNull: false)
  CollectionLocation? collectionLocation;
  String? collectionLocationDescription;
  String? procedureId;
  @JsonKey(includeToJson: false, includeIfNull: false)
  Procedure? procedure;
  String? procedureDescription;
  String? specieId;
  @JsonKey(includeToJson: false, includeIfNull: false)
  Specie? specie;
  String? specieDescription;
  String? tissueId;
  @JsonKey(fromJson: fromJsonBoolean)
  late bool hasTissue;
  @JsonKey(includeToJson: false, includeIfNull: false)
  Tissue? tissue;
  String? tissueDescription;
  String? responsibleUserId;
  @JsonKey(includeToJson: false, includeIfNull: false)
  User? responsibleUser;
  String? responsibleUserName;

  //state control
  String? get specieDisplay => specie?.description ?? specieDescription;
  String? get boxDisplay => box?.description ?? boxDescription;

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
    required this.hasCytogenetic,
    required this.hasTissue,
  });

  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);

  static String get scriptSqlite => """
            CREATE TABLE IF NOT EXISTS register (
              id TEXT PRIMARY KEY,
              active INTEGER,
              createdAt TEXT,
              updatedAt TEXT,
              code INTEGER,
              userId TEXT,
              number INTEGER,
              freezer TEXT,
              cytogenetic TEXT,
              collectionDate TEXT,
              observation TEXT,
              verticalPosition INTEGER,
              horizontalPosition INTEGER,
              boxId TEXT,
              boxDescription TEXT,
              genderId TEXT,
              genderDescription TEXT,
              collectionLocationId TEXT,
              collectionLocationDescription TEXT,
              procedureId TEXT,
              procedureDescription TEXT,
              specieId TEXT,
              specieDescription TEXT,
              tissueId TEXT,
              tissueDescription TEXT,
              responsibleUserId TEXT,
              responsibleUserName TEXT,
              hasCytogenetic BOOLEAN,
              hasTissue BOOLEAN
            );""";
}
