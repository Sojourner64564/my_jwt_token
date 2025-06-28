import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/links/url_links.dart';

@lazySingleton
class DioClient{
  final Dio dio = Dio(
    BaseOptions(
      validateStatus: (status) => [200, 400, 502].contains(status),
  ),
  );

  Future<Response<void>> login(String email) async{
    return dio.post<void>(UrlLinks.baseJwtAuth+UrlLinks.authLogin, data: {'email' : email},
    );
  }
}