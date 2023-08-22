import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/box/box.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/ibox_service.dart';
import 'package:sqflite/sqflite.dart';

class BoxService extends BaseService<Box> implements IBoxService {
  BoxService() : super(Box.fromJson);

  Stream<List<Box>> getAllWithPagination() async* {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}Box/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final boxes = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield boxes;
        // Verificar se há mais páginas para buscar
        if (boxes.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final box in boxes) {
          await Context().database.insert('box', box.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }
}
