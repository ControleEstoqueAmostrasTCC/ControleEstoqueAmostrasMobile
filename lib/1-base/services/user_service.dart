import 'dart:convert';

import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/dtos/post_acess_dto.dart';
import 'package:controle_estoque_amostras_app/1-base/dtos/user_claims_dto.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/iuser_service.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:sqflite/sqflite.dart';

class UserService extends BaseService<User> implements IUserService {
  UserService() : super(User.fromJson);

  Stream<List<User>> getAllWithPaginationStream() async* {
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

  @override
  Future<User?> authenticate(String username, String password) async {
    try {
      const url = '/Authenticate';
      final login = await super.post(
        {
          'username': username,
          'password': password,
        },
        urlComplement: url,
      );
      if (login == null) throw Exception();
      return login;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UserClaimsDTO?> getAllClaimsAndUserClaimsByUserId(String? userId) async {
    try {
      var url = '/GetAllClaimsAndUserClaimsByUserId';
      if (userId != null) {
        url += '?userId=$userId';
      }
      final response = await get(
        urlComplement: url,
        headers: {"Authorization": "Bearer ${user?.token}"},
      );
      if (response == null) throw Exception();
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return UserClaimsDTO.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> postAccessByUserId(List<PostAcessDTO> claimsUser, String userId) async {
    try {
      final url = Uri.parse('${baseUrl}User/PostAccessByUserId?userId=$userId');
      final response = await client.post(
        url,
        body: jsonEncode(claimsUser.map((e) => e.toJson()).toList()),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "Bearer ${user?.token}",
        },
      );
      if (hasErrorResponse(response)) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }
}
