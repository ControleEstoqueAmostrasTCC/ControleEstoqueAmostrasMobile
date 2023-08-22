import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/procedure/procedure.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/iprocedure_service.dart';
import 'package:sqflite/sqflite.dart';

class ProcedureService extends BaseService<Procedure> implements IProcedureService {
  ProcedureService() : super(Procedure.fromJson);

  Stream<List<Procedure>> getAllWithPagination() async* {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}Procedure/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final procedures = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield procedures;
        // Verificar se há mais páginas para buscar
        if (procedures.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final procedure in procedures) {
          await Context().database.insert('procedure', procedure.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }
}
