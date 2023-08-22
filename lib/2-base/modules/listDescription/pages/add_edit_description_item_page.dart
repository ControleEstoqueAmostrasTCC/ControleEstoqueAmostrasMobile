import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/controllers/add_edit_description_item_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:flutter/material.dart';

class AddEditDescriptionItemPage extends StatefulWidget {
  final BaseDescriptionEntity entity;
  const AddEditDescriptionItemPage({super.key, required this.entity});

  @override
  State<AddEditDescriptionItemPage> createState() => _AddEditDescriptionItemPageState();
}

class _AddEditDescriptionItemPageState extends State<AddEditDescriptionItemPage> {
  late final AddEditDescriptionItemController controller;

  @override
  void initState() {
    controller = AddEditDescriptionItemController(widget.entity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tipoConstrucao: TipoConstrucao.coluna,
      tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.scaffold,
      title: widget.entity.description ?? widget.entity.name,
      onTapDelete: () => controller.deleteOrUndeleteItem(context),
      deleted: !widget.entity.active,
      children: [
        Expanded(child: TextFieldWidget(controller: controller.itemController)),
        ButtonWidget(text: "SALVAR", onPressed: () => controller.saveItem(context)),
      ],
    );
  }
}
