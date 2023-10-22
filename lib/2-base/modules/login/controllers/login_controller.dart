import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/iuser_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/user_service.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/home/pages/home_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/popups.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  late final IUserService service;
  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  LoginController() {
    service = instanceManager.findInstanceService<User>("User") as UserService;
    _loginController = TextEditingController(
      text: kDebugMode ? "administrador" : null,
    );
    _passwordController = TextEditingController(
      text: kDebugMode ? "Lagenpe@2023" : null,
    );
    _formKey = GlobalKey<FormState>();
  }

  //Getters
  TextEditingController get loginController => _loginController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get formKey => _formKey;

  //Methods
  Future<void> login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    // "administrador", "Lagenpe@2023"
    final login = await service.authenticate(_loginController.text, _passwordController.text);
    if (login?.token == null) {
      return errorPopUp("Usuário e/ou senha incorretos", context);
    }
    if (login == null) {
      return errorPopUp("Erro ao realizar login", context);
    }
    user = login;
    user.login = _loginController.text;
    user.password = _passwordController.text;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
