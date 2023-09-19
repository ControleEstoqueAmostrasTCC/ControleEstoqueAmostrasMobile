import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/services/register_service.dart';
import 'package:flutter/foundation.dart';

class ListWebController extends ChangeNotifier {
  late List<Register> _registers;
  late final ValueNotifier<List<Register>> registers;

  ListWebController() {
    _registers = [];
    registers = ValueNotifier<List<Register>>(_registers);
    getRegisters();
  }

  Future<void> getRegisters() async {
    await for (final page in RegisterService().getAllWithPaginationStream()) {
      _registers.addAll(page);
      registers.notifyListeners();
      registers.value = _registers;
    }
  }
}
