import 'package:my_jwt_token/feature/main_screen_feature/data/model/user_id_model.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/entity/user_id_entity.dart';

extension ExtensionUserIdModelToEntity on UserIdModel{
  UserIdEntity toEntity(){
    return UserIdEntity(
      userId: userId,
    );
  }
}