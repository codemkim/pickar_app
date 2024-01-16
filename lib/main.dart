import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:pickar_app/ui/pages/camera_page.dart';
import 'package:pickar_app/ui/pages/home_page.dart';
import 'package:pickar_app/ui/pages/main_service_page.dart';
import 'package:pickar_app/ui/pages/service_page.dart';
import 'package:pickar_app/ui/pages/test_service_page.dart';
import 'config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ui/pages/init_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/login_pickar_page.dart';
import 'ui/pages/privacy_page.dart';
import 'ui/pages/register_page.dart';
void main() async {

  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  // 카카오 SDK 초기화
  kakao.KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_SDK_API_KEY']);
  // 카카오 맵 연동 
  AuthRepository.initialize(appKey: dotenv.env['KAKAO_MAP_API_KEY'] as String);
  // 네이버 맵 연동 
  // await NaverMapSdk.instance.initialize(
  //   clientId: dotenv.env['NAVER_MAP_CLIENT_ID'],
  //   onAuthFailed: (ex) {
  //       print("********* 네이버맵 인증오류 : $ex *********");
  //     });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const Pickar());
}

class Pickar extends StatelessWidget {
  const Pickar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pickar app',
      initialRoute: "/init",
      routes: {
            '/init': (context) => InitPage(),
            '/home': (context) => HomePage(),
            '/login': (context) => LoginPage(),
            '/login_pickar': (context) => LoginPickarPage(),
            '/privacy': (context) => PrivacyPage(),
            '/register': (context) => RegisterPage(),
            '/service': (context) => ServicePage(),
            '/camera': (context) => CameraPage(),
            '/main_service': (context) => MainServicePage(),
            '/test_service': (context) => TestServicePage(),
            

          });
  }
}