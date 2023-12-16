import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickar_app/social/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;
import 'package:http/http.dart' as http;


class FirebaseAuthModel {
  final String url = "https://us-central1-pickar-app.cloudfunctions.net/createCustomToken";

  Future<String> createCustomToken(Map<String, dynamic> user) async {
    final customTokenResponse = await http.post(Uri.parse(url), body: user);
    return customTokenResponse.body;
  }
}

class AuthProvider {
  final _firebaseAuthModel = FirebaseAuthModel();
  final _socialLogin = SocialLogin();
  bool isLogined = false;
  dynamic user;
  String loginPlatform = 'none';

  // 카카오 로그인 
  Future<bool> doKakaoLogin(dynamic data) async {
    loginPlatform = data;
    isLogined = await _socialLogin.kakaoLogin();
    
    try {
      if (isLogined) {
        user = await kakao.UserApi.instance.me();
        
        final token = await _firebaseAuthModel.createCustomToken({
          'uid': user!.id.toString(),
          'displayName': user!.kakaoAccount!.profile!.nickname,
          'email': user!.kakaoAccount!.email!,
        });
        await FirebaseAuth.instance.signInWithCustomToken(token);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> doGoogleLogin(dynamic data) async {
    loginPlatform = data;
    try {
      user = await _socialLogin.googleLogin();
      if (user != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: user?.accessToken,
          idToken: user?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);

        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print('e : ${e}');
      return false;
    }
  }

  Future<bool> logout() async {
    print(this.loginPlatform);
    try {
      switch ( this.loginPlatform) {
        case 'google':
          await _socialLogin.googleLogout();
          print('google logout complete');
          break;
        case 'kakao':
          await _socialLogin.kakaoLogout();
          print('kakao logout complete');
          break;
        case 'none':
          print('none logout');
          break;
      }
      await FirebaseAuth.instance.signOut();
      print('firebase logout complete');

      isLogined = false;
      user = null;
      return true;

    } on Exception catch (e) {

      print('e : ${e}');
      return false;
      
    }
  }

}
