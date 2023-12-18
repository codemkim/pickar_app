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

  Future<String> doBaseLogin(dynamic data) async {
    loginPlatform = 'base';
    String errorMesage = '로그인을 성공하셨습니다.';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: data['username'], password: data['password']);
      return errorMesage;

    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        errorMesage = '이메일/비밀번호가 틀렸습니다.';
      } else if (e.code == 'invalid-email') {
        errorMesage = '이메일 양식을 확인해주세요.';
      } else if (e.code == 'too-many-requests') {
        errorMesage = '과한 로그인 시도로 인한 에러';
      } else {
        errorMesage = '서버에러 발생, 관리자 문의';
      }
      return errorMesage;
    }
  }

  Future<String> doRegister(dynamic data) async {
    loginPlatform = 'base';
    String errorMesage = '회원가입에 성공하셨습니다.';
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: data['username'], password: data['password']);
      return errorMesage;

    } on FirebaseAuthException catch (e) {
      print('register error : ${e.code}');
      if (e.code == 'weak-password') {
        errorMesage = '비밀번호가 너무 짧습니다.';
      } else if (e.code == 'email-already-in-use') {
        errorMesage = '해당 이메일을 이미 사용중입니다.';
      } else if (e.code == 'invalid-email') {
        errorMesage = '이메일 양식을 확인해주세요.';
      } else {
        errorMesage = '서버에러 발생, 관리자 문의';
      }
      return errorMesage;
    }
  }

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

  // 구글 로그인 
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

  // 로그아웃 
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
        case 'base':
          print('base logout');
          break;
        case 'none':
          print('none logout');
          break;
      }
      await FirebaseAuth.instance.signOut();
      print('firebase logout complete');

      isLogined = false;
      user = null;
      loginPlatform = 'none';
      return true;

    } on Exception catch (e) {
      isLogined = false;
      user = null;
      loginPlatform = 'none';
      
      print('e : ${e}');
      return false;

    }
  }

}
