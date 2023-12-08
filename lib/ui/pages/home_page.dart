import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickar_app/ui/pages/login_page.dart';
import 'package:pickar_app/ui/pages/main_service_page.dart';
import 'package:pickar_app/ui/pages/service_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';



class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return MainServicePage();
                
                } else {
                  return LoginPage();
                  
                }
              } 
              return LoadingAnimationWidget.staggeredDotsWave(color: Colors.blue, size: 50);
            }
          );
  }
}