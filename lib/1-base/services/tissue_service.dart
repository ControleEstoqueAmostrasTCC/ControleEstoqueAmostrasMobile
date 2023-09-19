import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/tissue/tissue.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/itissue_service.dart';
import 'package:sqflite/sqflite.dart';

class TissueService extends BaseService<Tissue> implements ITissueService {
  TissueService() : super(Tissue.fromJson);

  Stream<List<Tissue>> getAllWithPaginationStream() async* {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}Tissue/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final tissues = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield tissues;
        // Verificar se há mais páginas para buscar
        if (tissues.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final tissue in tissues) {
          await Context().database.insert('tissue', tissue.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }
}
