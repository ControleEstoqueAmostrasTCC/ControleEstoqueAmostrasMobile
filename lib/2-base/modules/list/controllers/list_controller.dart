import 'package:connectivity/connectivity.dart';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/repositories/register_repository.dart';
import 'package:controle_estoque_amostras_app/1-base/services/register_service.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/masks.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/popups.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListController extends ChangeNotifier {
  late List<Register> _registers;
  late final ValueNotifier<List<Register>> registers;
  late final TextEditingController searchController;
  late final TextEditingController freezerController;
  late final TextEditingController boxController;
  late final TextEditingController cytogeneticController;
  late final bool hasCytogenetic;
  late final TextEditingController tissueController;
  late final bool hasTissue;
  late final TextEditingController genderController;
  late final TextEditingController specieController;
  late final TextEditingController collectionLocalController;
  late final TextEditingController collectionDateController;
  late final TextEditingController observationController;

  ListController() {
    _registers = [];
    registers = ValueNotifier<List<Register>>(_registers);
    searchController = TextEditingController()..addListener(() => filterRegisters());
    freezerController = TextEditingController();
    boxController = TextEditingController();
    cytogeneticController = TextEditingController();
    hasCytogenetic = false;
    tissueController = TextEditingController();
    hasTissue = false;
    genderController = TextEditingController();
    specieController = TextEditingController();
    collectionLocalController = TextEditingController();
    collectionDateController = TextEditingController();
    observationController = TextEditingController();
    getRegisters();
  }

  void filterRegisters() {
    final filteredRegisters = _registers
        .where(
          (register) =>
              register.number.toString().contains(searchController.text.toLowerCase()) &&
              (freezerController.text.isEmpty ||
                  (register.freezer?.toLowerCase().contains(freezerController.text.toLowerCase()) ?? false)) &&
              (boxController.text.isEmpty ||
                  (register.boxDisplay?.toLowerCase().contains(boxController.text.toLowerCase()) ?? false)) &&
              (cytogeneticController.text.isEmpty ||
                  (register.cytogenetic?.toLowerCase().contains(cytogeneticController.text.toLowerCase()) ?? false)) &&
              // (hasCytogenetic || register.hasCytogenetic) ||
              (tissueController.text.isEmpty ||
                  (register.tissueDisplay?.toLowerCase().contains(tissueController.text.toLowerCase()) ?? false)) &&
              // (hasTissue || register.hasTissue) ||
              (genderController.text.isEmpty ||
                  (register.genderDisplay?.toLowerCase().contains(genderController.text.toLowerCase()) ?? false)) &&
              (specieController.text.isEmpty ||
                  (register.specieDisplay?.toLowerCase().contains(specieController.text.toLowerCase()) ?? false)) &&
              (collectionLocalController.text.isEmpty ||
                  (register.collectionLocationDisplay
                          ?.toLowerCase()
                          .contains(collectionLocalController.text.toLowerCase()) ??
                      false)) &&
              (collectionDateController.text.isEmpty ||
                  register.collectionDateDisplay.toLowerCase().contains(collectionDateController.text.toLowerCase())),
        )
        .toList();
    registers.notifyListeners();
    registers.value = filteredRegisters;
  }

  Future<void> getRegisters() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _registers = [];

    if (connectivityResult == ConnectivityResult.none && !kIsWeb) {
      _registers = await RegisterRepository().getAll();
    } else {
      await for (final page in RegisterService().getAllWithPaginationStream()) {
        _registers.addAll(page);
        filterRegisters();
      }
    }
    filterRegisters();
  }

  Future<void> viewEditRegister(BuildContext context, Register register) async {
    menuController.changePage(1);
    addRegisterController.resetVariables();
    await addRegisterController.initMethods();
    addRegisterController.fillVariablesByRegister(register);
  }

  Future<void> openAdvancedFilter(BuildContext context) async {
    await showListPopUp(
      "Filtrar Espécies",
      ListView(
        children: [
          TextFieldWidget(
            controller: searchController,
            hintText: "Código/Registro",
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: freezerController,
            hintText: "Freezer",
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: boxController,
            hintText: "Caixa",
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: cytogeneticController,
            hintText: "Citogenética",
          ),
          const SizedBox(height: 10),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: hasCytogenetic,
          //       onChanged: (value) {
          //         hasCytogenetic = value!;
          //         notifyListeners();
          //       },
          //     ),
          //     const SizedBox(width: 10),
          //     Text("Tem Citogenética"),
          //   ],
          // ),
          // const SizedBox(height: 10),
          TextFieldWidget(
            controller: tissueController,
            hintText: "Tecido",
          ),
          const SizedBox(height: 10),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: hasTissue,
          //       onChanged: (value) {
          //         hasTissue = value!;
          //         notifyListeners();
          //       },
          //     ),
          //     const SizedBox(width: 10),
          //     Text("Tem Tecido"),
          //   ],
          // ),
          // const SizedBox(height: 10),
          TextFieldWidget(
            controller: genderController,
            hintText: "Sexo",
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: specieController,
            hintText: "Espécie",
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: collectionLocalController,
            hintText: "Local",
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: collectionDateController,
            hintText: "Data",
            keyboardType: TextInputType.number,
            inputFormatters: [
              date,
            ],
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: observationController,
            hintText: "Observação",
          ),
        ],
      ),
      "Filtrar",
      () {
        Navigator.pop(context);
      },
      context,
    );
    filterRegisters();
  }
}
