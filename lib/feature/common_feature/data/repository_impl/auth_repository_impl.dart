import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/core/network/network_info.dart';
import 'package:my_jwt_token/core/storage_keys/storage_keys.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/local_ds/security_storage_client.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/remote_ds/dio_client.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this.networkInfo,
    this.dioClient,
    this.securityStorageClient,
  );

  final NetworkInfo networkInfo;
  final DioClient dioClient;
  final SecurityStorageClient securityStorageClient;

  @override
  Future<void> fetchLogin(String email) async {
    if (!await networkInfo.isConnected) {
      throw NoInternetFailure();
    }

    final response = await dioClient.login(email);

    if (response.statusCode == 400) {
      throw InvalidEmailFailure();
    }
    if (response.statusCode == 502) {
      throw ServerFailure();
    }
  }

  @override
  Future<void> fetchConfirmCode(String email, int code) async {
    if (!await networkInfo.isConnected) {
      throw NoInternetFailure();
    }

    final response = await dioClient.confirmCode(email, code);

    if (response.statusCode == 400) {
      throw ExpiredEmailCodeFailure();
    }
    if (response.statusCode == 502) {
      throw ServerFailure();
    } else {
      final Map<String, dynamic> data = response.data;
      securityStorageClient.write(StorageKeys.jwtTokenKey, data['jwt']);
      securityStorageClient.write(StorageKeys.jwtTokenKey, data['refresh_token']);
    }
  }
}
