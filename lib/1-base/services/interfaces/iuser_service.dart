import 'package:controle_estoque_amostras_app/1-base/dtos/post_acess_dto.dart';
import 'package:controle_estoque_amostras_app/1-base/dtos/user_claims_dto.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/1-base/services/base/ibase_service.dart';

abstract interface class IUserService implements IBaseService<User> {
  Future<User?> authenticate(String username, String password);
  Future<UserClaimsDTO?> getAllClaimsAndUserClaimsByUserId(String? userId);
  Future<bool> postAccessByUserId(List<PostAcessDTO> claimsUser, String userId);
}
