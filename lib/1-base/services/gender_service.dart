import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/gender/gender.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/igender_service.dart';
import 'package:sqflite/sqflite.dart';

class GenderService extends BaseService<Gender> implements IGenderService {
  GenderService() : super(Gender.fromJson);

  Stream<List<Gender>> getAllWithPaginationStream() async* {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}Gender/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final genders = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield genders;
        // Verificar se há mais páginas para buscar
        if (genders.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final gender in genders) {
          await Context().database.insert('gender', gender.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }
}
