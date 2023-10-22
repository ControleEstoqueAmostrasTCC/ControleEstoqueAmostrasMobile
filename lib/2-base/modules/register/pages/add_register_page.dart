import 'dart:async';
import 'package:controle_estoque_amostras_app/1-base/models/box/box.dart';
import 'package:controle_estoque_amostras_app/1-base/models/collectionLocation/collection_location.dart';
import 'package:controle_estoque_amostras_app/1-base/models/gender/gender.dart';
import 'package:controle_estoque_amostras_app/1-base/models/procedure/procedure.dart';
import 'package:controle_estoque_amostras_app/1-base/models/specie/specie.dart';
import 'package:controle_estoque_amostras_app/1-base/models/tissue/tissue.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/register/controllers/add_register_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/string_extension.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/validators.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:searchfield/searchfield.dart';

class AddRegisterPage extends StatefulWidget {
  const AddRegisterPage({super.key});

  @override
  State<AddRegisterPage> createState() => _AddRegisterPageState();
}

class _AddRegisterPageState extends State<AddRegisterPage> with Validators {
  late final AddRegisterController controller;

  @override
  void initState() {
    controller = addRegisterController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Form(
          key: controller.formKey,
          child: IgnorePointer(
            ignoring: user.canAddRegister == false,
            child: Column(
              // tipoConstrucao: TipoConstrucao.lista,
              // tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.scaffold,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // autovalidateMode: AutovalidateMode.always,
              // formKey: controller.formKey,
              // floatingActionButton: FloatingActionButton(
              //   backgroundColor: lightBackground,
              //   onPressed: () => controller.saveRegister(context),
              //   child: const Icon(Icons.save),
              // ),
              children: [
                TextFieldWidget(
                  controller: controller.registerNumberController,
                  hintText: "Número de Registro",
                  validator: defaultValidator,
                ),
                ValueListenableBuilder(
                  valueListenable: controller.boxes,
                  builder: (context, _, __) => SearchFieldWidget(
                    label: "Caixa",
                    controller: controller.boxController,
                    suggestions:
                        controller.boxes.value.map((e) => SearchFieldListItem((e.description ?? e.name)!, item: e)).toList(),
                    onSuggestionTap: (value) => controller.selectedBox.value = value.item as Box,
                    validator: (value) => value.isNullOrEmpty ? "Caixa inválida" : null,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.genders,
                  builder: (context, _, __) => SearchFieldWidget(
                    label: "Sexo",
                    controller: controller.genderController,
                    suggestions: controller.genders.value
                        .map((e) => SearchFieldListItem((e.description ?? e.name)!, item: e))
                        .toList(),
                    onSuggestionTap: (value) => controller.selectedGender.value = value.item as Gender,
                    validator: (value) => value.isNullOrEmpty ? "Sexo inválido" : null,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.collectionLocations,
                  builder: (context, _, __) => SearchFieldWidget(
                    label: "Local de Coleta",
                    controller: controller.collectionLocationController,
                    suggestions: controller.collectionLocations.value
                        .map((e) => SearchFieldListItem((e.description ?? e.name)!, item: e))
                        .toList(),
                    onSuggestionTap: (value) =>
                        controller.selectedCollectionLocation.value = value.item as CollectionLocation,
                    validator: (value) => value.isNullOrEmpty ? "Local de Coleta inválido" : null,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.procedures,
                  builder: (context, _, __) => SearchFieldWidget(
                    label: "Procedimento",
                    controller: controller.procedureController,
                    suggestions: controller.procedures.value
                        .map((e) => SearchFieldListItem((e.description ?? e.name)!, item: e))
                        .toList(),
                    onSuggestionTap: (value) => controller.selectedProcedure.value = value.item as Procedure,
                    validator: (value) => value.isNullOrEmpty ? "Procedimento inválido" : null,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.species,
                  builder: (context, _, __) => SearchFieldWidget(
                    label: "Espécie",
                    controller: controller.specieController,
                    suggestions: controller.species.value
                        .map((e) => SearchFieldListItem((e.description ?? e.name)!, item: e))
                        .toList(),
                    onSuggestionTap: (value) => controller.selectedSpecie.value = value.item as Specie,
                    validator: (value) => value.isNullOrEmpty ? "Espécie inválida" : null,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.tissues,
                  builder: (context, _, __) => SearchFieldWidget(
                    label: "Tecido",
                    controller: controller.tissueController,
                    suggestions: controller.tissues.value
                        .map((e) => SearchFieldListItem((e.description ?? e.name)!, item: e))
                        .toList(),
                    onSuggestionTap: (value) => controller.selectedTissue.value = value.item as Tissue,
                    validator: (value) => value.isNullOrEmpty ? "Tecido inválido" : null,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.hasTissue,
                  builder: (_, hasTissue, __) => CheckboxWidget(
                    label: "Possui Tecido",
                    value: hasTissue,
                    onChanged: (_) => controller.hasTissue.value = !hasTissue,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.users,
                  builder: (context, _, __) => SearchFieldWidget(
                    label: "Responsável",
                    controller: controller.userController,
                    suggestions: controller.users.value
                        .map((e) => SearchFieldListItem(e.name!, item: e, child: TextWidget(e.name!)))
                        .toList(),
                    onSuggestionTap: (value) => controller.selectedUser.value = value.item as User,
                    validator: (value) => value.isNullOrEmpty ? "Responsável inválido" : null,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: controller.verticalPositionController,
                        hintText: "Posição Vertical",
                        validator: defaultValidator,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: TextFieldWidget(
                        controller: controller.horizontalPositionController,
                        hintText: "Posição Horizontal",
                        validator: defaultValidator,
                        maxLength: 1,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[A-Z]")),
                        ],
                      ),
                    ),
                  ],
                ),
                TextFieldWidget(controller: controller.freezerController, hintText: "Freezer", validator: defaultValidator),
                TextFieldWidget(
                  controller: controller.cytogeneticController,
                  hintText: "Citogenética",
                  validator: defaultValidator,
                ),
                ValueListenableBuilder(
                  valueListenable: controller.hasCytogenetic,
                  builder: (_, hasCytogenetic, __) => CheckboxWidget(
                    label: "Possui Citogenética",
                    value: hasCytogenetic,
                    onChanged: (_) => controller.hasCytogenetic.value = !hasCytogenetic,
                  ),
                ),
                TextFieldWidget(
                  controller: controller.collectionDateController,
                  hintText: "Data de Coleta",
                  validator: defaultValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    controller.dateMask,
                  ],
                ),
                TextFieldWidget(controller: controller.observationController, hintText: "Observação", maxLines: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchFieldWidget extends StatelessWidget {
  final String label;
  final List<SearchFieldListItem> suggestions;
  final FutureOr<void> Function(SearchFieldListItem) onSuggestionTap;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const SearchFieldWidget({
    super.key,
    required this.suggestions,
    required this.onSuggestionTap,
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(label),
        SearchField(
          itemHeight: 5.5.h,
          controller: controller,
          suggestions: suggestions,
          validator: validator,
          searchInputDecoration: InputDecoration(
            hintText: label,
            helperText: "",
            // prefixIcon: null, //const Icon(Icons.search),
            filled: true,
            fillColor: white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          ),
          onSearchTextChanged: (value) {
            if (value.isNullOrEmpty) return [];
            final filteredSuggestions = suggestions
                .where(
                  (suggestion) =>
                      removeDiacritics(suggestion.searchKey.toLowerCase()).contains(removeDiacritics(value.toLowerCase())),
                )
                .toList();
            controller.text = value;
            controller.selection = TextSelection.fromPosition(TextPosition(offset: value.length));
            return filteredSuggestions;
          },
          onSuggestionTap: (value) async {
            await onSuggestionTap(value);
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }
}

///Checkbox widget with a label text
class CheckboxWidget extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool?)? onChanged;

  const CheckboxWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        TextWidget(label),
      ],
    );
  }
}
