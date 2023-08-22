import 'dart:async';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/controllers/list_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/converters.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/fonts.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
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
    return
        // BackgroundWidget(
        // tipoConstrucao: TipoConstrucao.coluna,
        // tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.scaffold,
        // children:
        Column(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<Register>>(
            valueListenable: controller.registers,
            builder: (context, _, __) => RefreshIndicator(
              onRefresh: () async {
                controller.getRegisters();
              },
              child: ListView.builder(
                itemCount: controller.registers.value.length,
                itemBuilder: (context, index) {
                  final register = controller.registers.value[index];
                  return GestureDetector(
                    onTap: () => controller.viewEditRegister(context, register),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      decoration: BoxDecoration(
                        color: blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TextDescriptionWidget(title: "Nome", description: register.number.toString()),
                          TextDescriptionWidget(title: "Espécie", description: register.specieDisplay),
                          TextDescriptionWidget(
                            title: "Caixa",
                            description:
                                "${register.boxDisplay} (${register.horizontalPosition} ${returnLetterFromNumber(register.verticalPosition!)})",
                          ),
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
          decoration: InputDecoration(
            counterText: "",
            helperText: validator == null ? null : "",
            hintText: hintText,
            prefixIcon: prefixIcon, //const Icon(Icons.search),
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
