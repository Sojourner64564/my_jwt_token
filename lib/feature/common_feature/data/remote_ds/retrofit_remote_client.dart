import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_jwt_token/core/links/url_links.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_remote_client.g.dart';

@RestApi()
abstract class RetrofitRemoteClient {
  factory RetrofitRemoteClient(Dio dio, {String? baseUrl}) =
  _RetrofitRemoteClient;

  @GET(UrlLinks.baseJwtAuth+UrlLinks.authLogin)
  Future<void> fetchLogin();


  @POST('')
  Future<void> fetchConfirmCode(
      @Body() String body,
      );
}
@injectable
class RetrofitRemoteClientInstance {
  RetrofitRemoteClient client() {
    return _RetrofitRemoteClient(Dio());
  }
}
