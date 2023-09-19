import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/login/controllers/login_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _ListDescriptionPageState();
}

class _ListDescriptionPageState extends State<LoginPage> with Validators {
  late final LoginController controller;

  @override
  void initState() {
    controller = instanceManager.registerInstance(LoginController(), entityName: "User");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tipoConstrucao: TipoConstrucao.coluna,
      tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.scaffold,
      children: [
        Expanded(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  controller: controller.loginController,
                  hintText: "Login",
                  validator: defaultValidator,
                ),
                SizedBox(height: 1.h),
                TextFieldWidget(
                  controller: controller.passwordController,
                  validator: defaultValidator,
                  hintText: "Senha",
                  obscureText: true,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        ButtonWidget(text: "Login", onPressed: () => controller.login(context))
      ],
    );
  }
}
