import 'package:connectivity/connectivity.dart';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/repositories/register_repository.dart';
import 'package:controle_estoque_amostras_app/1-base/services/register_service.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ListController extends ChangeNotifier {
  late final ValueNotifier<List<Register>> _registers;
  late final TextEditingController searchController;

  ListController() {
    _registers = ValueNotifier([]);
    searchController = TextEditingController()..addListener(() => _registers.notifyListeners());
    getRegisters();
  }

  ValueNotifier<List<Register>> get registers {
    if (searchController.text.isEmpty) return _registers;
    final filteredRegisters = _registers.value
        .where((register) => register.number.toString().contains(searchController.text.toLowerCase()))
        .toList();
    notifyListeners();
    return ValueNotifier<List<Register>>(filteredRegisters);
  }

  Future<void> getRegisters() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _registers.value = [];

    if (connectivityResult == ConnectivityResult.none && !kIsWeb) {
      _registers.value = await RegisterRepository().getAll();
      _registers.notifyListeners();
    } else {
      await for (final page in RegisterService().getAllWithPagination()) {
        _registers.value.addAll(page);
        _registers.notifyListeners();
      }
    }
  }

  Future<void> viewEditRegister(BuildContext context, Register register) async {
    menuController.changePage(1);
    addRegisterController.resetVariables();
    await addRegisterController.initMethods();
    addRegisterController.fillVariablesByRegister(register);
  }
}
