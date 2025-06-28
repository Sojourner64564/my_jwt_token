import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/usecase/params_usecase.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/auth_repository.dart';

@lazySingleton
class ConfirmCodeUseCase implements ParamsUseCase<ConfirmCodeParams>{
  const ConfirmCodeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> call(ConfirmCodeParams params) async{
    return await _authRepository.fetchConfirmCode(params.email, int.parse(params.code));
  }
}

class ConfirmCodeParams{
  final String email;
  final String code;

  ConfirmCodeParams(this.email, this.code);
}