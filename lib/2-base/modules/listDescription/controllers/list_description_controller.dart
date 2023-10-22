import 'package:controle_estoque_amostras_app/1-base/dtos/post_acess_dto.dart';
import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/claims.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/user_service.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/popups.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart' as static_infos;
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ListDescriptionController<T extends BaseDescriptionEntity> extends ChangeNotifier {
  late final BaseService service;
  late final ValueNotifier<List<T>> _itens;
  late final String _entityName;
  late final TextEditingController _searchController;

  ListDescriptionController(this._entityName) {
    service = instanceManager.findInstanceService<T>(_entityName);
    _itens = ValueNotifier<List<T>>([]);
    _searchController = TextEditingController()..addListener(() => _itens.notifyListeners());
    _loadItens();
  }

  //Getters
  ValueNotifier<List<T>> get itens {
    if (_searchController.text.isEmpty) return _itens;
    final filteredItens = _itens.value.where((element) {
      final search = removeDiacritics(_searchController.text.toLowerCase());
      final value = removeDiacritics(element.description?.toLowerCase() ?? element.name?.toLowerCase() ?? "");
      return value.contains(search);
    }).toList();
    return ValueNotifier<List<T>>(filteredItens);
  }

  TextEditingController get searchController => _searchController;

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

  Future<void> addClaimUser(BuildContext context, int indexUser) async {
    final userService = instanceManager.findInstanceService("User") as UserService;
    final claimsUserDTO = await userService.getAllClaimsAndUserClaimsByUserId(_itens.value[indexUser].id);
    if (claimsUserDTO == null || claimsUserDTO.claims == null) {
      return errorPopUp(
        "Erro ao buscar acessos",
        context,
      );
    }
    final claims = claimsUserDTO.claims ?? [];
    final userClaims = claimsUserDTO.userClaims ?? [];
    final claimsNotAdded = claims;
    // .where(
    //   (element) => !userClaims
    //       .any((userClaim) => userClaim.claimType == element.claimType && userClaim.claimValue == element.claimValue),
    // )
    // .toList();
    final claimsNotAddedString = claimsNotAdded.map((e) => "${e.claimType} - ${e.claimValue}").toList();
    final claimsNotAddedStringSelected = <String>[];
    //add exists user claims
    claimsNotAddedStringSelected.addAll(
      userClaims.map((e) => "${e.claimType} - ${e.claimValue}").toList(),
    );
    await showListPopUp(
      "Editar Acessos",
      StatefulBuilder(
        builder: (context, setState) => ListView.builder(
          itemCount: claimsNotAddedString.length,
          itemBuilder: (context, index) => CheckboxListTile(
            title: TextWidget(claimsNotAddedString[index]),
            value: claimsNotAddedStringSelected.contains(claimsNotAddedString[index]),
            onChanged: (value) {
              if (value == true) {
                claimsNotAddedStringSelected.add(claimsNotAddedString[index]);
              } else {
                claimsNotAddedStringSelected.remove(claimsNotAddedString[index]);
              }
              setState(() {});
            },
          ),
        ),
      ),
      "Salvar",
      () async {
        final claimsToAdd = claimsNotAdded
            .where((element) => claimsNotAddedStringSelected.contains("${element.claimType} - ${element.claimValue}"))
            .toList();
        final claimsUser = claimsToAdd
            .map((e) => PostAcessDTO(claimType: e.claimType, claimValue: e.claimValue, isSelected: true))
            .toList();
        final postAccess = await userService.postAccessByUserId(claimsUser, _itens.value[indexUser].id);
        if (postAccess) {
          final claimsUserDTO = await userService.getAllClaimsAndUserClaimsByUserId(null);
          if (claimsUserDTO?.userClaims != null) {
            static_infos.user.claims =
                claimsUserDTO!.userClaims!.map((e) => Claims(value: e.claimValue, type: e.claimType)).toList();
          }
          await showDefaultPopUp(
            "Aviso",
            const TextWidget("Incluído com sucesso"),
            "Ok",
            () => Navigator.pop(context),
            context,
          );
          await _loadItens();
          return Navigator.pop(context);
        } else {
          return showDefaultPopUp(
            "Erro",
            const TextWidget("Erro ao editar acessos"),
            "Ok",
            () => Navigator.pop(context),
            context,
          );
        }
      },
      context,
    );
  }
}
