import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/login/controllers/login_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/assets.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/fonts.dart';
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
    return Scaffold(
      backgroundColor: lightGrey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
                  child: Container(
                    height: 25.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Image.asset(logoLagenpeLogin),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Center(
                    child: Column(
                      children: [
                        TextWidget(
                          "Bem-vindo ao Lagenpe®",
                          fontSize: medium,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Futura2',
                        ),
                        TextWidget(
                          "Controle de estoque",
                          fontSize: smallMedium,
                          fontFamily: 'Futura2',
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldWidget(
                          useLabel: false,
                          controller: controller.loginController,
                          hintText: "Usuário",
                          validator: defaultValidator,
                        ),
                        SizedBox(height: 1.h),
                        TextFieldWidget(
                          useLabel: false,
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
                ButtonWidget(text: "ACESSAR", onPressed: () => controller.login(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
