import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_location.g.dart';

@JsonSerializable()
class CollectionLocation extends BaseDescriptionEntity {
  CollectionLocation({
    required super.id,
    required super.active,
    required super.createdAt,
    super.updatedAt,
    super.code,
    super.userId,
    required super.description,
  });

  factory CollectionLocation.fromJson(Map<String, dynamic> json) => _$CollectionLocationFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionLocationToJson(this);
}
