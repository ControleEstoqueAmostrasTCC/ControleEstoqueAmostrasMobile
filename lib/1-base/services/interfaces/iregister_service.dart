import 'dart:typed_data';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/ibase_service.dart';

abstract interface class IRegisterService implements IBaseService<Register> {
  Future<Uint8List?> generateRegisterExcel();
}
