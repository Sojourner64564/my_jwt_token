import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/links/url_links.dart';
import 'package:my_jwt_token/core/storage_keys/storage_keys.dart';
import 'package:my_jwt_token/feature/common_feature/data/data_source/local_ds/security_storage_client.dart';

@lazySingleton
class DioClient{
  DioClient(this.dio, this.securityStorage){
    dio.interceptors.add(
      InterceptorsWrapper(
          onError: (DioException error, handler) async{
            if(error.response?.statusCode == 403){
              if(await securityStorage.contains(StorageKeys.refreshTokenKey)){
                await _refreshToken(await securityStorage.read(StorageKeys.refreshTokenKey) ?? '');

                final newJwt = await securityStorage.read(StorageKeys.jwtTokenKey);

                error.requestOptions.headers['Auth'] = 'Bearer $newJwt';

                return handler.resolve(await _retry(error.requestOptions));
              }
            }
            return handler.next(error);
          }
      ),
    );
  }

  final Dio dio;
  final SecurityStorageClient securityStorage;


  Future<Response<void>> login(String email) async{
    return await dio.post<void>(UrlLinks.baseJwtAuth+UrlLinks.authLogin, data: {'email' : email},
    );
  }

  Future<Response> confirmCode(String email, int code) async{
   final response =  await dio.post(UrlLinks.baseJwtAuth+UrlLinks.confirmCode,
      data: {'email' : email, 'code' : code},
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> data = response.data;
      await securityStorage.write(StorageKeys.jwtTokenKey, data['jwt']);
      await securityStorage.write(StorageKeys.refreshTokenKey, data['refresh_token']);
    }
    return response;
  }

  Future<Response> _refreshToken(String token) async{
    final response =  await dio.post(UrlLinks.baseJwtAuth+UrlLinks.refreshToken,
      data: {'token' : token},
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> data = response.data;
      await securityStorage.write(StorageKeys.jwtTokenKey, data['jwt']);
      await securityStorage.write(StorageKeys.refreshTokenKey, data['refresh_token']);
    }
    return response;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async{
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return await dio.request<dynamic>(
      requestOptions.path,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<Response> auth(String? jwt) async{
    return await dio.get(UrlLinks.baseJwtAuth+UrlLinks.auth,
      options: Options(
        headers: {
          'Auth' : "Bearer $jwt",
        }
      )
    );
  }
}