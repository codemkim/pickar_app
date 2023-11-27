import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kakao;
import 'package:pickar_app/ui/pages/home_page.dart';
import 'package:pickar_app/ui/pages/service_page.dart';
import 'config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ui/pages/init_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/login_pickar_page.dart';
import 'ui/pages/privacy_page.dart';
import 'ui/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  kakao.KakaoSdk.init(nativeAppKey: 'e5583bd8c079daebb72d7d57007521bf');
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
            

          });
  }
}