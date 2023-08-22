import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';

class RegisterRepository {
  Future<List<Register>> getAll() async {
    final registersDatabase = await Context().database.query('register');
    final registers = registersDatabase.map((e) => Register.fromJson(e)).toList();
    return registers;
  }
}
