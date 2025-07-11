import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/core/network/network_info.dart';
import 'package:my_jwt_token/core/storage_keys/storage_keys.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/local_ds/security_storage_client.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/remote_ds/dio_client.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/auth_repository.dart';
import 'package:my_jwt_token/feature/main_screen_feature/data/model/extension/extension_user_id_model_to_entity.dart';
import 'package:my_jwt_token/feature/main_screen_feature/data/model/user_id_model.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/entity/user_id_entity.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository{
  UserRepositoryImpl(this.networkInfo, this.dioClient, this.authRepository, this.securityStorage);

  final NetworkInfo networkInfo;
  final DioClient dioClient;
  final AuthRepository authRepository;
  final SecurityStorageClient securityStorage;

  @override
  Future<UserIdEntity> fetchUserId() async{
    if (!await networkInfo.isConnected) {
      throw NoInternetFailure();
    }

    final jwt = await securityStorage.read(StorageKeys.jwtTokenKey);
    final refresh = await securityStorage.read(StorageKeys.refreshTokenKey);

    if(refresh == null){
      throw AppFailure();
    }

    final response = await dioClient.auth(jwt);

    if(response.statusCode == 502){
      throw ServerFailure();
    }else{
      final model = UserIdModel.fromJson(response.data);
      return model.toEntity();
    }
  }
}