import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/popups.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ListDescriptionController<T extends BaseDescriptionEntity> extends ChangeNotifier {
  late final BaseService service;
  late final ValueNotifier<List<T>> _itens;
  late final String _entityName;

  ListDescriptionController(this._entityName) {
    service = instanceManager.findInstanceService<T>(_entityName);
    _itens = ValueNotifier<List<T>>([]);
    _loadItens();
  }

  //Getters
  ValueNotifier<List<T>> get itens => _itens;

  //Methods
  Future<void> _loadItens() async {
    final itens = await (service.getAll() as Future<List<BaseDescriptionEntity>>);
    itens.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
    _itens.value = itens as List<T>;
  }

  Future<void> addItem(BuildContext context) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool addItem = false;
    await showDefaultPopUp(
      "Adicionar",
      Form(
        key: formKey,
        child: TextFieldWidget(controller: controller, validator: (value) => value!.isEmpty ? "Campo obrigatório" : null),
      ),
      "Adicionar",
      () {
        addItem = formKey.currentState!.validate();

        if (addItem) {
          Navigator.pop(context);
        }
      },
      context,
    );
    if (!addItem) return;
    final newEntity = BaseDescriptionEntity(
      id: const Uuid().v4(),
      code: 0,
      active: true,
      createdAt: DateTime.now(),
      description: controller.text,
      name: controller.text,
    );
    //verify if already exists on itens list
    if (_itens.value.any(
      (element) =>
          removeDiacritics((element.description ?? element.name)!.toLowerCase()) ==
          removeDiacritics((newEntity.description ?? newEntity.name)!.toLowerCase()),
    )) {
      return showDefaultPopUp(
        "Erro",
        const TextWidget("Já existe um item com essa descrição"),
        "Ok",
        () => Navigator.pop(context),
        context,
      );
    }
    final entity = await service.post(newEntity.toJson());
    if (entity != null) {
      showDefaultPopUp(
        "Aviso",
        const TextWidget("Incluído com sucesso"),
        "Ok",
        () => Navigator.pop(context),
        context,
      );
      await _loadItens();
      return;
    } else {
      return showDefaultPopUp(
        "Erro",
        const TextWidget("Erro ao adicionar item"),
        "Ok",
        () => Navigator.pop(context),
        context,
      );
    }
  }
}
