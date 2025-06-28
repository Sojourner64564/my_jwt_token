import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/usecase/type_usecase.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/entity/user_id_entity.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/repository/user_repository.dart';

@lazySingleton
class FetchUserIdUseCase implements TypeUsecase<UserIdEntity>{
  FetchUserIdUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<UserIdEntity> call() async{
    return await _userRepository.fetchUserId();
  }
}