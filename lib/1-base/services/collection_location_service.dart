import 'dart:convert';
import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/collectionLocation/collection_location.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/icollection_location_service.dart';
import 'package:sqflite/sqflite.dart';

class CollectionLocationService extends BaseService<CollectionLocation> implements ICollectionLocationService {
  CollectionLocationService() : super(CollectionLocation.fromJson);

  Stream<List<CollectionLocation>> getAllWithPagination() async* {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}CollectionLocation/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final collectionLocations = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield collectionLocations;
        // Verificar se há mais páginas para buscar
        if (collectionLocations.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final collectionLocation in collectionLocations) {
          await Context()
              .database
              .insert('collectionLocation', collectionLocation.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }
}
