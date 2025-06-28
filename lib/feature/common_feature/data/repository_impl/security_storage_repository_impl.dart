import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/local_ds/security_storage_client.dart';
import 'package:my_jwt_token/feature/common_feature/domain/repository/security_storage_repository.dart';

@LazySingleton(as: SecurityStorageRepository)
class SecurityStorageRepositoryImpl implements SecurityStorageRepository {
  SecurityStorageRepositoryImpl(this.securityStorageClient);

  final SecurityStorageClient securityStorageClient;

  @override
  Future<String?> read(String key) async{
    return await securityStorageClient.read(key);
  }

  @override
  Future<void> write(String key, String? value) async{
    return await securityStorageClient.write(key, value);
  }

}