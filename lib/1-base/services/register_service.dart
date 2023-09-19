import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/iregister_service.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class RegisterService extends BaseService<Register> implements IRegisterService {
  RegisterService() : super(Register.fromJson);

  Stream<List<Register>> getAllWithPaginationStream() async* {
    try {
      int page = 1;
      const pageSize = 300;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}Register/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final registers = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield registers;
        // Verificar se há mais páginas para buscar
        if (registers.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final register in registers) {
          register.boxDescription = register.box?.description;
          register.collectionLocationDescription = register.collectionLocation?.description;
          register.genderDescription = register.gender?.description;
          register.procedureDescription = register.procedure?.description;
          register.specieDescription = register.specie?.description;
          register.tissueDescription = register.tissue?.description;
          register.responsibleUserName = register.responsibleUser?.name;
          if (!kIsWeb)
            await Context().database.insert('register', register.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }

  Future<List<Register>> getAllWithPagination() async {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      List<Register> registers = [];
      do {
        final url = Uri.parse(
          '${baseUrl}Register/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        registers.addAll(json.map((e) => fromJson(e as Map<String, dynamic>)).toList());
        // Verificar se há mais páginas para buscar
        if (registers.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final register in registers) {
          register.boxDescription = register.box?.description;
          register.collectionLocationDescription = register.collectionLocation?.description;
          register.genderDescription = register.gender?.description;
          register.procedureDescription = register.procedure?.description;
          register.specieDescription = register.specie?.description;
          register.tissueDescription = register.tissue?.description;
          register.responsibleUserName = register.responsibleUser?.name;
          if (!kIsWeb)
            await Context().database.insert('register', register.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
      return registers;
    } catch (_) {
      return [];
    }
  }

  Future<List<Register>> getByFilters(String field, String id) async {
    try {
      final url = Uri.parse(
        '${baseUrl}Register/GetByFilters/?${field}Id=$id',
      );
      final response = await client.get(url);
      if (hasErrorResponse(response)) throw Exception();
      final json = jsonDecode(response.body) as List;
      final registers = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      return registers;
    } catch (_) {
      return [];
    }
  }
}
