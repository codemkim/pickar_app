abstract class SocialAuth {
  Future<bool> kakaoLogin();
  Future<bool> kakaoLogout();
  Future<dynamic> googleLogin();
  Future<bool> googleLogout();
}