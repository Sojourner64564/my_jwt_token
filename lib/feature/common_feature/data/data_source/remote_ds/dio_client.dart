import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/links/url_links.dart';

@lazySingleton
class DioClient{
  final Dio dio = Dio(
    BaseOptions(
      validateStatus: (status) => [200, 400, 403, 502].contains(status),
  ),
  );

  Future<Response<void>> login(String email) async{
    return await dio.post<void>(UrlLinks.baseJwtAuth+UrlLinks.authLogin, data: {'email' : email},
    );
  }

  Future<Response> confirmCode(String email, int code) async{
   return await dio.post(UrlLinks.baseJwtAuth+UrlLinks.confirmCode,
      data: {'email' : email, 'code' : code},
    );
  }

  Future<Response> refreshToken(String token) async{
    return await dio.post(UrlLinks.baseJwtAuth+UrlLinks.refreshToken,
      data: {'token' : token},
    );
  }

  Future<Response> auth(String jwt) async{
    return await dio.get(UrlLinks.baseJwtAuth+UrlLinks.auth,
      options: Options(
        headers: {
          'Auth' : "Bearer $jwt",
        }
      )
    );
  }
}