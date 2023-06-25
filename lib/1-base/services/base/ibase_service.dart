abstract interface class IBaseService<T> {
  Future<List<T>> getByUpdatedAt({DateTime? updatedAt});
  Future<List<T>> getAll();
  Future<T?> post(Map<String, dynamic> jsonEntity);
}
