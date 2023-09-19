import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/specie/specie.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/ispecie_service.dart';
import 'package:sqflite/sqflite.dart';

class SpecieService extends BaseService<Specie> implements ISpecieService {
  SpecieService() : super(Specie.fromJson);

  Stream<List<Specie>> getAllWithPaginationStream() async* {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}Specie/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final species = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield species;
        // Verificar se há mais páginas para buscar
        if (species.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final specie in species) {
          await Context().database.insert('specie', specie.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }
}
