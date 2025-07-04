import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/usecase/params_usecase.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/auth_repository.dart';

@lazySingleton
class LoginUseCase implements ParamsUseCase<String>{
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call(String email) async{
    return _authRepository.fetchLogin(email);
  }
}