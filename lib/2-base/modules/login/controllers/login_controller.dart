import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/1-base/services/user_service.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/home/pages/home_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/popups.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  late final UserService service;

  LoginController() {
    service = instanceManager.findInstanceService<User>("User") as UserService;
  }

  //Getters

  //Methods
  Future<void> login(BuildContext context) async {
    final login = await service.authenticate("administrador", "Lagenpe@2023");
    if (login?.token == null) {
      errorPopUp("Usuário e/ou senha incorretos", context);
    }
    user = login;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
