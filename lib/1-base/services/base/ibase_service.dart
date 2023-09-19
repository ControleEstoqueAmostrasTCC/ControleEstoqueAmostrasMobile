import 'package:http/http.dart';

abstract interface class IBaseService<T> {
  Future<List<T>> getByUpdatedAt({DateTime? updatedAt});
  Future<List<T>> getAll();
  Future<T?> post(Map<String, dynamic> jsonEntity, {String? urlComplement, Map<String, String>? headers});
  Future<Response?> get({String? urlComplement, Map<String, String>? headers});
}
