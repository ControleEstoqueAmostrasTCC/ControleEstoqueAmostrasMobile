import 'package:controle_estoque_amostras_app/2-base/modules/home/controllers/reset_password_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final ResetPasswordController controller;

  @override
  void initState() {
    controller = ResetPasswordController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tipoConstrucao: TipoConstrucao.coluna,
      tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.material,
      title: "Redefinir Senha",
      children: [
        Expanded(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  controller: controller.oldPasswordController,
                  prefixIcon: const Icon(Icons.lock),
                  hintText: "Senha atual",
                  obscureText: true,
                  useLabel: false,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return "Campo obrigatório";
                    if (user.password != null && value != user.password) return "Senha incorreta";
                    return null;
                  },
                ),
                TextFieldWidget(
                  controller: controller.newPasswordController,
                  prefixIcon: const Icon(Icons.lock),
                  hintText: "Nova senha",
                  obscureText: true,
                  useLabel: false,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                ),
                TextFieldWidget(
                  controller: controller.confirmNewPasswordController,
                  prefixIcon: const Icon(Icons.lock),
                  hintText: "Confirmar nova senha",
                  obscureText: true,
                  useLabel: false,
                  maxLines: 1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return "Campo obrigatório";
                    if (value != controller.newPasswordController.text) return "As senhas não coincidem";
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        ButtonWidget(text: "REDEFINIR", onPressed: () => controller.resetPassword(context)),
      ],
    );
  }
}
