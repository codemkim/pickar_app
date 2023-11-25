
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;
import 'package:pickar_app/models/firebase_auth_model.dart';
import 'package:pickar_app/social/social_login.dart';

class SocialModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  kakao.User? user;

  SocialModel(this._socialLogin);

  Future login() async {
    final _firebaseAuthModel = FirebaseAuthModel();
    isLogined = await _socialLogin.login();

    if (isLogined) {
      user = await kakao.UserApi.instance.me();
      
      final token = await _firebaseAuthModel.createCustomToken({
        'uid': user!.id.toString(),
        'displayName': user!.kakaoAccount!.profile!.nickname,
        'email': user!.kakaoAccount!.email!,
        'photoURL': user!.kakaoAccount!.profile!.profileImageUrl,


      });

      await FirebaseAuth.instance.signInWithCustomToken(token);
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}