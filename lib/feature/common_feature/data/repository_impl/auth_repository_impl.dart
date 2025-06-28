import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/failure/failure.dart';
import 'package:my_jwt_token/core/network/network_info.dart';
import 'package:my_jwt_token/feature/common_feature/data/remote_ds/dio_client.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this.networkInfo,
    this.dioClient,
  );

  final NetworkInfo networkInfo;
  final DioClient dioClient;

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
}
