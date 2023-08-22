import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/snackbars.dart';
import 'package:flutter/material.dart';

class AddEditDescriptionItemController<T extends BaseDescriptionEntity> extends ChangeNotifier {
  late final BaseService service;
  late final TextEditingController _itemController;
  late final T _entity;

  AddEditDescriptionItemController(this._entity) {
    _itemController = TextEditingController(
      text: _entity.description ?? _entity.name,
    );
    service = instanceManager.findInstanceService(_entity.runtimeType.toString());
  }

  //Getters
  TextEditingController get itemController => _itemController;

  Future<void> deleteOrUndeleteItem(BuildContext context) async {
    _entity.active = !_entity.active;
    final entity = await service.post(_entity.toJson());
    if (entity != null) {
      await showDefaultSnackBar(
        "${_entity.description ?? _entity.name} ${_entity.active ? "reativado" : "deletado"} com sucesso",
        context,
      );
      return Navigator.pop(context);
    } else {
      await showDefaultSnackBar("Erro ao ${_entity.active ? "remover" : "reativar"} ${_entity.description}", context);
    }
  }

  Future<void> saveItem(BuildContext context) async {
    if (_itemController.text.isEmpty) return;
    _entity.description = _itemController.text;
    _entity.name = _itemController.text;
    final entity = await service.post(_entity.toJson());
    if (entity != null) {
      await showDefaultSnackBar("Item alterado com sucesso", context);
      return Navigator.pop(context);
    } else {
      await showDefaultSnackBar("Erro ao alterar item", context);
    }
  }
}
