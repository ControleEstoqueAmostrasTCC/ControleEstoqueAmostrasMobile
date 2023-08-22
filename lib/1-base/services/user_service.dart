import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/iuser_service.dart';
import 'package:sqflite/sqflite.dart';

class UserService extends BaseService<User> implements IUserService {
  UserService() : super(User.fromJson);

  Stream<List<User>> getAllWithPagination() async* {
    try {
      int page = 1;
      const pageSize = 1000;
      bool hasMorePages = true;
      do {
        final url = Uri.parse(
          '${baseUrl}User/GetAllWithPagination?pageSize=$pageSize&pageNumber=$page',
        );
        final response = await client.get(url);
        if (hasErrorResponse(response)) throw Exception();
        final json = jsonDecode(response.body) as List;
        final users = json.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        yield users;
        // Verificar se há mais páginas para buscar
        if (users.length < pageSize) {
          hasMorePages = false;
        } else {
          page++;
        }
        for (final user in users) {
          await Context().database.insert('user', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }
      } while (hasMorePages);
    } catch (_) {
      yield [];
    }
  }
}
