import 'package:my_jwt_token/feature/main_screen_feature/domain/entity/user_id_entity.dart';

abstract class UserRepository{
  Future<UserIdEntity> fetchUserId();
}