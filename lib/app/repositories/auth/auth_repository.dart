abstract class AuthRepository {
  Future<String> login(String usuario, String password, String url);
}
