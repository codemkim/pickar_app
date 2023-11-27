import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;
import 'package:pickar_app/social/social_auth.dart';

class SocialLogin implements SocialAuth {
  @override
  Future<bool> login() async{
    try {
      bool isInstalled = await kakao.isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await kakao.UserApi.instance.loginWithKakaoTalk();
          return true;

        } catch (e) {
          return false;
        }
      } else {
        try {
          await kakao.UserApi.instance.loginWithKakaoAccount();
          return true;

        } catch (e) {
          return false; 
        }
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async{
    try {
      await kakao.UserApi.instance.unlink();
      return true;
    } catch (e) {
      return false;
    }
  }
  
  
  @override
  Future<dynamic> googleLogin() async {

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if ( googleAuth != null) {
        return googleAuth;
      } else {
        return null;
      }
    } catch (e) {
      print('google login error : ${e}');
      return null;

    }
  }
  @override
  Future<bool> googleLogout() async{
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

}