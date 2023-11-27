abstract class SocialAuth {
  Future<bool> login();
  Future<bool> logout();
  Future<dynamic> googleLogin();
  Future<bool> googleLogout();
}