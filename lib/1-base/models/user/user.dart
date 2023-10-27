import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/claims.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/mappers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseDescriptionEntity {
  List<Claims>? claims;
  String? token;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? login;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? password;

  bool get canViewTissueMenu => claims?.any((e) => e.type == "Tecido" && e.value == "Visualizar") ?? false;
  bool get canViewBoxMenu => claims?.any((e) => e.type == "Caixa" && e.value == "Visualizar") ?? false;
  bool get canViewCollectionLocationMenu => claims?.any((e) => e.type == "LocalColeta" && e.value == "Visualizar") ?? false;
  bool get canViewGenderMenu => claims?.any((e) => e.type == "Sexo" && e.value == "Visualizar") ?? false;
  bool get canViewProcedureMenu => claims?.any((e) => e.type == "Procedimento" && e.value == "Visualizar") ?? false;
  bool get canViewRegisterMenu => claims?.any((e) => e.type == "Registro" && e.value == "Visualizar") ?? false;
  bool get canAddRegister => claims?.any((e) => e.type == "Registro" && e.value == "Criar") ?? false;
  bool get canViewSpecieMenu => claims?.any((e) => e.type == "Espécie" && e.value == "Visualizar") ?? false;
  bool get canViewUserMenu => claims?.any((e) => e.type == "Usuário" && e.value == "Visualizar") ?? false;
  bool get canEditAccessUser => claims?.any((e) => e.type == "Usuário" && e.value == "Editar Acesso") ?? false;
  bool get canDownloadExcel => claims?.any((e) => e.type == "Usuário" && e.value == "DownloadExcel") ?? false;
  bool get canUploadExcel => claims?.any((e) => e.type == "Usuário" && e.value == "UploadExcel") ?? false;

  User({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required super.name,
    super.description,
    this.claims,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
