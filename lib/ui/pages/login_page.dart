import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:pickar_app/blocs/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
            color: Color(0xff64b9b2), size: 50),
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/images/petmoji_logo.png'),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 110,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '반려동물',
                            style: TextStyle(
                              color: Color(0xff64b9b2),
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
                    top: 155,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '사랑 ',
                            style: TextStyle(
                              color: Color(0xff64b9b2),
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
                    top: 200,
                    child: Text(
                      '새로운 문화',
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
                    top: 285,
                    child: Text(
                      '반려인을 위한',
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
                    top: 310,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '나만의 ',
                            style: TextStyle(
                              color: Color(0xFF737A8B),
                              fontSize: 17,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w300,
                              height: 0.08,
                              letterSpacing: -0.51,
                            ),
                          ),
                          TextSpan(
                            text: '이모지, ',
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
                            text: '펫모지',
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
                    right: -62,
                    top: 200,
                    child: Lottie.asset('assets/animations/main_dog.json', width: 300, height: 300),
                  ),
                  Positioned(
                    right: -30,
                    top: 440,
                    child: Image.asset('assets/images/bottom_shadow.png'),
                  ),
                
                
                  Positioned(
                    top: 520,
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
                    top: 580,
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
                    top: 640,
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
                            // backgroundColor: Colors.green,
                             backgroundColor: Color(0xff64b9b2),
                            padding: EdgeInsets.zero, // 내부 패딩을 0으로 설정하여 왼쪽 정렬이 가능하도록 함
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10), // 여기를 조절하여 아이콘의 왼쪽 패딩을 설정
                                  child: Image.asset('assets/images/petmoji_icon.png', width: 33), // 아이콘으로 사용할 이미지
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '펫모지 이메일 로그인',
                                      
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