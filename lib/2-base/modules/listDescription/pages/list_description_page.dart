import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/controllers/list_description_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/pages/add_edit_description_item_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListDescriptionPage extends StatefulWidget {
  final String entityName;
  final String title;
  const ListDescriptionPage({super.key, required this.entityName, required this.title});

  @override
  State<ListDescriptionPage> createState() => _ListDescriptionPageState();
}

class _ListDescriptionPageState extends State<ListDescriptionPage> {
  late final ListDescriptionController controller;

  @override
  void initState() {
    controller =
        instanceManager.registerInstance(ListDescriptionController(widget.entityName), entityName: widget.entityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tipoConstrucao: TipoConstrucao.coluna,
      tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.material,
      title: widget.title,
      onTapAdd: () => controller.addItem(context),
      children: [
        TextFieldWidget(
          controller: controller.searchController,
          prefixIcon: const Icon(Icons.search),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: controller.itens,
            builder: (context, _, __) => ListView.builder(
              itemCount: controller.itens.value.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditDescriptionItemPage(
                        entity: controller.itens.value[index],
                      ),
                    ),
                  );
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    border: controller.itens.value[index].active ? null : Border.all(color: red),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextDescriptionWidget(
                              title: "",
                              description: controller.itens.value[index].description ?? controller.itens.value[index].name,
                            ),
                          ),
                          if (widget.entityName == "User" && (user.canEditAccessUser))
                            IconButton(
                              icon: const Icon(Icons.security, color: black),
                              onPressed: () => controller.addClaimUser(context, index),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
