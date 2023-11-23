import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              left: 24,
              top: 40,
              child: Container(
                width: 72,
                height: 28,
                child: Image.asset('assets/images/main_logo.png'),
              ),
            ),
          ]
        )
      )
    );
  }
}