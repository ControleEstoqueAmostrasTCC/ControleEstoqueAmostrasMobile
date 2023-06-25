import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/interfaces/iregister_service.dart';

class RegisterService extends BaseService<Register> implements IRegisterService {
  RegisterService() : super(Register.fromJson);
}
