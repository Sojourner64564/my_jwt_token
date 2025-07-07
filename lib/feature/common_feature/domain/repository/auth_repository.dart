
abstract class AuthRepository{
  Future<void> fetchLogin(String email);
  Future<void> fetchConfirmCode(String email, int code);
  //Future<void> fetchRefreshToken(String token);
}