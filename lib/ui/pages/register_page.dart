import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _key = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController pwTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false;

  SharedPreferences? prefs;


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
              height: double.infinity,
              color: Colors.transparent,
              padding: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.08),
              
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,  // 이 부분 추가
                      children: [
                              GestureDetector(
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
                              ),
                              SizedBox(height: 40),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '픽카',
                                      style: TextStyle(
                                        color: Color(0xFF1F222B),
                                        fontSize: 28,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.bold,
                                        height: 0.08,
                                        letterSpacing: -0.51,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 서비스 회원가입',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.normal,
                                        height: 0.08,
                                        letterSpacing: -0.51,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                '아래의 회원정보를 모두 입력해주세요',
                                style: TextStyle(
                                  color: Color(0xFF747A8B),
                                  fontSize: 17,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w300,
                                  height: 0,
                                  letterSpacing: -1.08,
                                ),
                              ),
                              SizedBox(height: 50),
                              Text(
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
                              SizedBox(height: 20),
                              TextFormField(
                                
                              autofocus: true,
                              keyboardType: TextInputType.emailAddress,
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
                            SizedBox(height: 20),
                            Text(
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
                            SizedBox(height: 20),
                              TextFormField(
                                autofocus: true,
                              keyboardType: TextInputType.text,
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
                            SizedBox(height: 20),
                            Text(
                                '성함',
                                style: TextStyle(
                                        color: Color(0xFF1F222B),
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w300,
                                        height: 0.08,
                                        letterSpacing: -0.51,
                                      ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                autofocus: true,
                              keyboardType: TextInputType.text,
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
                                hintText: '성함을 입력해주세요',
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
                              
                              controller: nameTextController,
                              
                            ),
                            SizedBox(height: 20),
                            Text(
                                '전화번호',
                                style: TextStyle(
                                        color: Color(0xFF1F222B),
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w300,
                                        height: 0.08,
                                        letterSpacing: -0.51,
                                      ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                autofocus: true,
                              keyboardType: TextInputType.phone,
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
                                hintText: '010 - 0000 - 0000',
                                hintStyle: TextStyle(
                                fontSize: 17, // 글꼴 크기
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
                              
                              controller: phoneTextController,
                              
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                                        onPressed: () async{
                                          if (_key.currentState!.validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            try {
                                              
                                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                                email: emailTextController.text, password: pwTextController.text);
                                                
                                              prefs?.setString('useremail', emailTextController.text);
                                              Navigator.of(context).pushNamedAndRemoveUntil(
                                                        '/home',
                                                        (Route<dynamic> route) => false);
                                            } on FirebaseAuthException catch (e) {
                                              print(e.code);
                                              if (e.code == 'weak-password') {
                                                _showMessageDialog('비밀번호가 너무 짧습니다.');
                                              } else if (e.code == 'email-already-in-use') {
                                                _showMessageDialog('해당 이메일을 이미 사용중입니다.');
                                              } else if (e.code == 'invalid-email') {
                                                _showMessageDialog('이메일 양식을 확인해주세요.');
                                              }
              
                                            }
              
                                          } else {
                                            _showMessageDialog('빈칸을 모두 채워주세요!');
                                          }
                                        
                                        
                                          
                                        },
                                        child: Text(
                                          "회원가입",
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
                          ]),
                        )
          )
          )
        )
        )
      );
  }
}