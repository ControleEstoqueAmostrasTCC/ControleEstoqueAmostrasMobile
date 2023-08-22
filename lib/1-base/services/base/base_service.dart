import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/models/base/base_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/ibase_service.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/string_extension.dart';
import 'package:http/http.dart';

class BaseService<T extends BaseEntity> implements IBaseService<T> {
  late final Client client;
  late final String baseUrl;
  late final T Function(Map<String, dynamic>) fromJson;

  BaseService(this.fromJson) {
    client = Client();
    // baseUrl = 'http://10.10.10.35:17262/api/';
    // baseUrl = 'https://controleestoqueamostrastcc-hugoesteves.b4a.run/api/';
    // baseUrl = 'https://controleestoqueamostrasapi.azurewebsites.net/api/';
    baseUrl = 'https://lagenpeapi.azurewebsites.net/api/';
  }

  @override
  Future<List<T>> getByUpdatedAt({DateTime? updatedAt}) async {
    try {
      final url = Uri(
        host: '$baseUrl${T.toString().capitalize()}/GetByUpdatedAt',
        queryParameters: {'updatedAt': updatedAt?.toIso8601String()},
      );
      final response = await client.get(url);
      if (hasErrorResponse(response)) throw Exception();
      final json = jsonDecode(response.body) as List;
      return json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<T>> getAll() async {
    try {
      final url = Uri.parse('$baseUrl${T.toString().capitalize()}/GetAll');
      final response = await client.get(url);
      if (hasErrorResponse(response)) throw Exception();
      final json = jsonDecode(response.body) as List;
      return json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<T?> post(Map<String, dynamic> jsonEntity) async {
    try {
      final url = Uri.parse('$baseUrl${T.toString().capitalize()}');
      final response = await client.post(
        url,
        body: jsonEncode(jsonEntity),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
      if (hasErrorResponse(response)) throw Exception();
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return fromJson(json);
    } catch (_) {
      return null;
    }
  }

  bool hasErrorResponse(Response response) {
    return response.statusCode != 200;
  }
}
