
import 'package:flutter/material.dart';
import 'package:pickar_app/models/social_model.dart';
import 'package:pickar_app/social/kakao_login.dart';

class ServicePage extends StatefulWidget {

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  final socialModel = SocialModel(SocialLogin());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await socialModel.logout();
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            } 
          
          ,
           child: Text('logout'))
          ],)
    );
  }
}