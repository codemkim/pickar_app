import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pickar_app/blocs/auth_bloc.dart';


class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  SharedPreferences? prefs;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      opacity: 0.5,
      progressIndicator: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blue, size: 50),
      child: Scaffold(
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
                  Positioned(
                    left: 165,
                    top: 151,
                    child: Container(
                      width: 28,
                      height: 45.07,
                      child: Image.asset('assets/images/logo_small.png'),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 100,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '주차 공간',
                            style: TextStyle(
                              color: Color(0xFF235DFF),
                              fontSize: 36,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              letterSpacing: -1.08,
                            ),
                          ),
                          TextSpan(
                            text: '을',
                            style: TextStyle(
                              color: Color(0xFF1E212A),
                              fontSize: 36,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              height: 0,
                              letterSpacing: -1.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 145,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '공유 ',
                            style: TextStyle(
                              color: Color(0xFF235DFF),
                              fontSize: 36,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 0,
                              letterSpacing: -1.08,
                            ),
                          ),
                          TextSpan(
                            text: '하는',
                            style: TextStyle(
                              color: Color(0xFF1E212A),
                              fontSize: 36,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              height: 0,
                              letterSpacing: -1.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 190,
                    child: Text(
                      '새로운 방법',
                      style: TextStyle(
                        color: Color(0xFF1E212A),
                        fontSize: 36,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w300,
                        height: 0,
                        letterSpacing: -1.08,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 275,
                    child: Text(
                      '모두를 위한',
                      style: TextStyle(
                              color: Color(0xFF737A8B),
                              fontSize: 17,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              height: 0.08,
                              letterSpacing: -0.51,
                            ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 300,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '주차 리워드',
                            style: TextStyle(
                              color: Color(0xFF737A8B),
                              fontSize: 17,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 0.08,
                              letterSpacing: -0.51,
                            ),
                          ),
                          TextSpan(
                            text: ' 플랫폼, 픽카',
                            style: TextStyle(
                              color: Color(0xFF737A8B),
                              fontSize: 17,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              height: 0.08,
                              letterSpacing: -0.51,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 200,
                    child: Image.asset('assets/images/car.png'),
                  ),
                  Positioned(
                    right: 0,
                    top: 440,
                    child: Image.asset('assets/images/bottom_shadow.png'),
                  ),
                
                
                  Positioned(
                    top: 500,
                    right: 20,
                    left: 20,
                    child: TextButton(
                          onPressed: () async{
                            setState(() {
                              _isLoading = true;
                            });
                            bool isLogined = await authBloc.doGoogleLogin('google');
                            setState(() {
                              _isLoading = false;
                            });
                            // socialModel.googleLogin();
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: Size(315, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Color(0xFFEBEBEB))
                            ),
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero, // 내부 패딩을 0으로 설정하여 왼쪽 정렬이 가능하도록 함
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 16), // 여기를 조절하여 아이콘의 왼쪽 패딩을 설정
                                  child: Image.asset('assets/images/google_logo.png', width: 24), // 아이콘으로 사용할 이미지
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '구글 로그인',
                                      textAlign: TextAlign.center, 
                                      style: TextStyle(
                                      color: Colors.black, // 텍스트 색상을 검정색으로 설정
                                    
                                      fontSize: 16
                                    ),
                                    )
                                    
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
              
                  ),
                  Positioned(
                    top: 560,
                    right: 20,
                    left: 20,
                    child: TextButton(
                          onPressed: () async{
                            setState(() {
                              _isLoading = true;
                            });
                            bool isLogined = await authBloc.doKakaoLogin('kakao');
                            setState(() {
                              _isLoading = false;
                            });
                            
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: Size(315, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color(0xFFFEE500),
                            padding: EdgeInsets.zero, // 내부 패딩을 0으로 설정하여 왼쪽 정렬이 가능하도록 함
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 16), // 여기를 조절하여 아이콘의 왼쪽 패딩을 설정
                                  child: Image.asset('assets/images/kakao_logo.png', width: 20), // 아이콘으로 사용할 이미지
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '카카오톡 로그인',
                                      textAlign: TextAlign.center, 
                                      style: TextStyle(
                                      color: Colors.black,
                                      
                                      fontSize: 16,
                                    ),// 텍스트를 컨테이너의 가운데로 정렬
                                      
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
              
                  ),
                  Positioned(
                    top: 620,
                    right: 20,
                    left: 20,
                    child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                            '/login_pickar',
                                            (Route<dynamic> route) => false);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: Size(315, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color(0xFF235DFF),
                            padding: EdgeInsets.zero, // 내부 패딩을 0으로 설정하여 왼쪽 정렬이 가능하도록 함
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 16), // 여기를 조절하여 아이콘의 왼쪽 패딩을 설정
                                  child: Image.asset('assets/images/pickar_logo.png', width: 24), // 아이콘으로 사용할 이미지
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '픽카 이메일 로그인',
                                      
                                      textAlign: TextAlign.center, // 텍스트를 컨테이너의 가운데로 정렬
                                      style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      
                                    ),// 텍스트를 컨테
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),
                  Positioned.fill( // 화면을 채우는 Positioned 위젯
                  top: 720,
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff747A8B),
                        ),
                        children: <TextSpan>[
                          TextSpan(text: '간편 로그인 회원가입 시 '),
                          TextSpan(
                            text: '서비스 이용약관 개인정보 처리방침',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '에 동의하는 것으로 간주됩니다.'),
                        ],
                      ),
                    ),
                  ),
                  )
                ],
              )
        ),
      ),
    );
  }
}