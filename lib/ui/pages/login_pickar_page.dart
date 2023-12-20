
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pickar_app/blocs/auth_bloc.dart';

class LoginPickarPage extends StatefulWidget {

  @override
  State<LoginPickarPage> createState() => _LoginPickarPageState();
}

class _LoginPickarPageState extends State<LoginPickarPage> {

  final _key = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController pwTextController = TextEditingController();

  SharedPreferences? prefs;
  bool _passwordVisible = false;
  bool _isLoading = false;



  @override
  void initState() {
    Future.delayed(Duration(microseconds: 100), () async {
        // load shared preferences
      prefs = await SharedPreferences.getInstance();
      print("loading shared preferences");
      setState(() => emailTextController.text = prefs?.getString('useremail') ?? "");
    });
  }


  void _showMessageDialog(String message) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle, // 원형 모양
              ),
            ),
            SizedBox(width: 10), // 점과 텍스트 사이의 간격
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Pretendard'),
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 1), // 1초 후에 사라짐
        behavior: SnackBarBehavior.floating, // 'floating'으로 설정하여 하단에서 떠오름
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 모서리 둥글게
        ),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top:20), // 하단에 10만큼의 마진을 줌
      ),
    );
    
  }
  

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
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              
          child: Form(
            key: _key,
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 40,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          '/home',
                                          (Route<dynamic> route) => false);
                    }, 
                    child: Container(
                      width: 72,
                      height: 28,
                      child: Image.asset('assets/images/main_logo.png'),
                    ),
                  )
                ),
                Positioned(
                  left: 20,
                  top: 110,
                  child: Text(
                    '픽카',
                    style: TextStyle(
                            color: Color(0xFF1F222B),
                            fontSize: 28,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.bold,
                            height: 0.08,
                            letterSpacing: -0.51,
                          ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 145,
                  child: Text(
                    '회원으로 로그인',
                    style: TextStyle(
                            color: Color(0xFF1F222B),
                            fontSize: 28,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w300,
                            height: 0.08,
                            letterSpacing: -0.51,
                          ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 215,
                  child: Text(
                    '이메일',
                    style: TextStyle(
                            color: Color(0xFF1F222B),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w300,
                            height: 0.08,
                            letterSpacing: -0.51,
                          ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 235,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40, // 적절한 너비 지정
                    height: 100, // 적절한 높이 지정
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        fillColor: Colors.transparent,
                        hintText: '이메일을 입력해주세요',
                        hintStyle: TextStyle(
                        fontSize: 16, // 글꼴 크기
                        color: Color(0xff989FB2), // 텍스트 색상
                          fontWeight: FontWeight.normal, // 글꼴 두께
                          fontFamily: 'Pretendard',
                          // 여기에 다른 스타일 속성 추가 가능
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xffD7DDED), // 변경된 경계선 색상
                            width: 1, // 변경된 경계선 너비
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        
                      ),
                      style: TextStyle(
                        fontSize: 16, // 글꼴 크기
                        color: Color(0xff989FB2), // 텍스트 색상
                        fontWeight: FontWeight.normal, // 글꼴 두께
                        fontFamily: 'Pretendard',
                        // 여기에 다른 스타일 속성 추가 가능
                      ),
                      
                      controller: emailTextController,
                      
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 310,
                  child: Text(
                    '비밀번호',
                    style: TextStyle(
                            color: Color(0xFF1F222B),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w300,
                            height: 0.08,
                            letterSpacing: -0.51,
                          ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 330,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40, // 적절한 너비 지정
                    height: 100, // 적절한 높이 지정
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      obscureText: !_passwordVisible,
                      validator: (val) {
                        if ( val!.isEmpty) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        fillColor: Colors.transparent,
                        suffixIcon: IconButton(
                                    icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                        hintText: '비밀번호를 입력해주세요',
                        hintStyle: TextStyle(
                        fontSize: 16, // 글꼴 크기
                        color: Color(0xff989FB2), // 텍스트 색상
                          fontWeight: FontWeight.normal, // 글꼴 두께
                          fontFamily: 'Pretendard',
                          // 여기에 다른 스타일 속성 추가 가능
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color(0xffD7DDED), // 변경된 경계선 색상
                            width: 1, // 변경된 경계선 너비
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        
                      ),
                      style: TextStyle(
                        fontSize: 16, // 글꼴 크기
                        color: Color(0xff989FB2), // 텍스트 색상
                        fontWeight: FontWeight.normal, // 글꼴 두께
                        fontFamily: 'Pretendard',
                        // 여기에 다른 스타일 속성 추가 가능
                      ),
                      
                      controller: pwTextController,
                      
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top:410,
                  child: Container(
                            width: MediaQuery.of(context).size.width - 40, // 적절한 너비 지정
                            height: 200,
                            child: Column(children: [
                              ElevatedButton(
                                onPressed: () async{
                                  setState(() { _isLoading = true; });

                                  Map<String, dynamic> payload = {
                                    "username": emailTextController.text,
                                    "password": pwTextController.text,
                                  };

                                  if (_key.currentState!.validate()) {
                                    
                                    String errorMessage = await authBloc.doBaseLogin(payload);
                                    setState(() { _isLoading = false; });
                                
                                    if (errorMessage == '로그인을 성공하셨습니다.' ) {
                                      prefs?.setString('useremail', emailTextController.text);
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                                '/home',
                                                (Route<dynamic> route) => false);

                                    } else {
                                      _showMessageDialog(errorMessage);
                                    }
                                    
                                  } else {
                                    _showMessageDialog('이메일/비밀번호를 확인해주세요');
                                  }
                                },
                                child: Text(
                                  "로그인",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor: Color(0xff235DFF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    elevation: 5,
                                    shadowColor: Colors.black),
                              ),
                              const SizedBox(height: 35),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          '/privacy',
                                          (Route<dynamic> route) => false);
                                    },
                                    child: const Text('픽카가 처음이신가요?',
                                        style: TextStyle(
                                          color: Color(0xff235DFF),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600
                                          )),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      
                                    },
                                    child: const Text('비밀번호를 잊어버리셨나요?',
                                        style: TextStyle(
                                          color: Color(0xff747A8B),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500
                                          )),
                                  )
                                ],
                              )
                            ])),
                )
                
              ]
            ),
          )
        )
        )
      ),
    );
  }
}

