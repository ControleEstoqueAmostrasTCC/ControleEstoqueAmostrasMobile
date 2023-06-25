import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/services/register_service.dart';
import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  late final ValueNotifier<List<Register>> _registers;
  HomeController() {
    _registers = ValueNotifier([]);
    getRegisters();
  }

  ValueNotifier<List<Register>> get registers => _registers;

  Future<void> getRegisters() async {
    final registers = await RegisterService().getAll();
    _registers.value = registers;
  }
}
