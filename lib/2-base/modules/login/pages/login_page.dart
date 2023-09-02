import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/controllers/list_description_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/pages/add_edit_description_item_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/login/controllers/login_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _ListDescriptionPageState();
}

class _ListDescriptionPageState extends State<LoginPage> {
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
      tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.material,
      title: "Login",
      children: [Expanded(child: ButtonWidget(text: "Login", onPressed: () => controller.login(context)))],
    );
  }
}
