import 'package:json_annotation/json_annotation.dart';

part 'claims.g.dart';

@JsonSerializable()
class Claims {
  String? issuer;
  String? originalIssuer;
  String? type;
  String? value;
  String? valueType;

  Claims({this.issuer, this.originalIssuer, this.type, this.value, this.valueType});

  factory Claims.fromJson(Map<String, dynamic> json) => _$ClaimsFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsToJson(this);
}
