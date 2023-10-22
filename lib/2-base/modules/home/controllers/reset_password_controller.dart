import 'package:controle_estoque_amostras_app/1-base/services/user_service.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/popups.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResetPasswordController extends ChangeNotifier {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;
  late final GlobalKey<FormState> _formKey;

  ResetPasswordController() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  //Getters
  TextEditingController get oldPasswordController => _oldPasswordController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmNewPasswordController => _confirmNewPasswordController;
  GlobalKey<FormState> get formKey => _formKey;

  //Methods
  Future<void> resetPassword(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final userService = instanceManager.findInstanceService("User") as UserService;
    final resetPassword = await userService.updatePassword(
      newPasswordController.text,
    );
    if (!resetPassword) {
      return errorPopUp("Erro ao alterar senha", context);
    }
    successPopUp("Senha alterada com sucesso", context);
    user.password = newPasswordController.text;
    _confirmNewPasswordController.clear();
    _newPasswordController.clear();
    _oldPasswordController.clear();
    formKey.currentState?.reset();
  }
}
