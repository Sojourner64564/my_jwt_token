import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/core/network/network_info.dart';
import 'package:my_jwt_token/core/storage_keys/storage_keys.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/remote_ds/dio_client.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/auth_repository.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/security_storage_repository.dart';
import 'package:my_jwt_token/feature/main_screen_feature/data/model/extension/extension_user_id_model_to_entity.dart';
import 'package:my_jwt_token/feature/main_screen_feature/data/model/user_id_model.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/entity/user_id_entity.dart';
import 'package:my_jwt_token/feature/main_screen_feature/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository{
  UserRepositoryImpl(this.networkInfo, this.dioClient, this.authRepository, this.securityStorageRepository);

  final NetworkInfo networkInfo;
  final DioClient dioClient;
  final AuthRepository authRepository;
  final SecurityStorageRepository securityStorageRepository;

  @override
  Future<UserIdEntity> fetchUserId() async{
    if (!await networkInfo.isConnected) {
      throw NoInternetFailure();
    }

    final jwt = await securityStorageRepository.read(StorageKeys.jwtTokenKey);
    final refresh = await securityStorageRepository.read(StorageKeys.refreshTokenKey);

    if(jwt == null){
      print('jwt == null');
      throw AppFailure();
    }
    if(refresh == null){
      print('refresh == null');
      throw AppFailure();
    }

    final response = await dioClient.auth(jwt);

    if(response.statusCode == 403){
      print('fetchUserId 403');
      await authRepository.fetchRefreshToken(refresh).catchError((error, stackTrace){
        if(error is NoInternetFailure){
          throw NoInternetFailure();
        }
        if(error is UserDoesNotExistFailure){
          throw UserDoesNotExistFailure();
        }
        if(error is ServerFailure){
          print('refreshToken serverFailure');
          throw ServerFailure();
        }
      });

      final jwt = await securityStorageRepository.read(StorageKeys.jwtTokenKey);
      if(jwt == null){
        print('jwt == null');
        throw AppFailure();
      }

      final response = await dioClient.auth(jwt);

      if(response.statusCode == 403){
        print('new dioClient.auth 403');
        throw ServerFailure();
      }
      if(response.statusCode == 502){
        print('new dioClient.auth 502');
        throw ServerFailure();
      }else{
        print(response.data);
        final model = UserIdModel.fromJson(response.data);
        return model.toEntity();
      }
    }

    if(response.statusCode == 502){
      print('dioClient.auth 502');
      throw ServerFailure();
    }else{
      print(response.data);

      final model = UserIdModel.fromJson(response.data);
      return model.toEntity();
    }
  }
}