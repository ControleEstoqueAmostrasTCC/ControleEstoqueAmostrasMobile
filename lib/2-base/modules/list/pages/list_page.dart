import 'dart:async';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/controllers/list_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/converters.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/fonts.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final ListController controller;

  @override
  void initState() {
    controller = listController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<Register>>(
            valueListenable: controller.registers,
            builder: (context, _, __) => RefreshIndicator(
              onRefresh: () async {},
              // onRefresh: () async {
              //   controller.getRegisters();
              // },
              child: ListView.builder(
                itemCount: controller.registers.value.length,
                itemBuilder: (context, index) {
                  final register = controller.registers.value[index];
                  return GestureDetector(
                    onTap: () => controller.viewEditRegister(context, register),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      decoration: BoxDecoration(
                        color: blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TextDescriptionWidget(title: "Código/Registro", description: register.number.toString()),
                          RowTextDescriptionWidget(
                            title1: "Freezer",
                            description1: register.freezer,
                            title2: "Caixa",
                            description2:
                                "${register.boxDisplay} (${register.horizontalPosition} ${returnLetterFromNumber(register.verticalPosition!)})",
                          ),
                          RowTextDescriptionWidget(
                            title1: "Citogenética",
                            description1: register.cytogenetic,
                            title2: "Tem Citogenética",
                            description2: register.hasCytogenetic ? "Sim" : "Não",
                          ),
                          RowTextDescriptionWidget(
                            title1: "Tecido",
                            description1: register.tissueDisplay,
                            title2: "Tem Tecido",
                            description2: register.hasTissue ? "Sim" : "Não",
                          ),
                          RowTextDescriptionWidget(
                            title1: "Sexo",
                            description1: register.genderDisplay,
                            title2: "Espécie",
                            description2: register.specieDisplay,
                          ),
                          RowTextDescriptionWidget(
                            title1: "Local",
                            description1: register.collectionLocationDisplay,
                            title2: "Data",
                            description2: register.collectionDateDisplay,
                          ),
                          if (!register.observation.isNullOrEmpty)
                            TextDescriptionWidget(title: "Observação", description: register.observation)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TextDescriptionWidget extends StatelessWidget {
  final String title;
  final String? description;
  const TextDescriptionWidget({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: .5.h),
      child: Row(
        children: [
          TextWidget("$title: ", fontWeight: FontWeight.bold),
          Expanded(child: TextWidget(description ?? "Não Informado", fontSize: 14)),
        ],
      ),
    );
  }
}

class RowTextDescriptionWidget extends StatelessWidget {
  final String title1;
  final String? description1;
  final String title2;
  final String? description2;
  const RowTextDescriptionWidget(
      {super.key, required this.title1, this.description1, required this.title2, this.description2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextDescriptionWidget(title: title1, description: description1)),
        Expanded(child: TextDescriptionWidget(title: title2, description: description2)),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final String? fontFamily;
  const TextWidget(this.text, {super.key, this.color, this.fontSize, this.decoration, this.fontWeight, this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? smallMedium,
        decoration: decoration,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? 'Lexent',
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final double? radius;
  final FutureOr<void> Function()? onPressed;
  final String text;
  const ButtonWidget({super.key, this.radius, this.onPressed, required this.text});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (widget.onPressed is Future) {
          setState(() => isLoading = true);
          await widget.onPressed?.call();
          setState(() => isLoading = false);
        } else {
          widget.onPressed?.call();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: lightBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 2.w),
        ),
        side: const BorderSide(color: white),
        padding: EdgeInsets.zero,
      ),
      child: isLoading
          ? Center(
              child: SizedBox(
                height: 5.w,
                width: 5.w,
                child: const CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
            )
          : TextWidget(widget.text, color: white, fontSize: medium),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffixIcon;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.maxLength,
    this.inputFormatters = const [],
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hintText != null) TextWidget(hintText!),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          maxLines: maxLines,
          obscureText: obscureText,
          decoration: InputDecoration(
            counterText: "",
            helperText: validator == null ? null : "",
            hintText: hintText,
            prefixIcon: prefixIcon, //const Icon(Icons.search),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          ),
        ),
      ],
    );
  }
}

enum TipoConstrucao {
  coluna,
  lista;
}

enum TipoConstrucaoFundoTela {
  material,
  scaffold;
}
