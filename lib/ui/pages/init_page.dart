import 'package:flutter/material.dart';
import 'package:pickar_app/ui/pages/home_page.dart';
import 'dart:async';

class InitPage extends StatefulWidget {
  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  
   @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(), // 여기서 LoginScreen은 로그인 화면 위젯입니다.
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 로고 이미지
            Image.asset('assets/images/init_logo.png', width: 250, height: 250,),
            SizedBox(height: 20),
            // 로딩 인디케이터
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}