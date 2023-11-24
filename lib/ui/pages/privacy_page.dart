import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {

  bool isAllChecked = false;
  bool isItem1Checked = false;
  bool isItem2Checked = false;
  bool isItem3Checked = false;

  void _handleAllChecked(bool? newValue) {
    setState(() {
      isAllChecked = newValue!;
      isItem1Checked = newValue;
      isItem2Checked = newValue;
      isItem3Checked = newValue;
    });
  }

  void _handleItemChanged(bool? newValue, int itemIndex) {
    setState(() {
      switch (itemIndex) {
        case 1:
          isItem1Checked = newValue!;
          break;
        case 2:
          isItem2Checked = newValue!;
          break;
        case 3:
          isItem3Checked = newValue!;
          break;
      }
      // 모든 항목들이 체크되었는지 확인
      isAllChecked = isItem1Checked && isItem2Checked && isItem3Checked;
    });
  }

  void _showMessageDialog(String message) {
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
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            
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
              left: 24,
              top: 110,
              child: Text.rich(
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
            ),
            Positioned(
              left: 24,
              top: 150,
              child: Text(
                '정상적인 픽카서비스 이용을 위해',
                style: TextStyle(
                  color: Color(0xFF747A8B),
                  fontSize: 17,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w300,
                  height: 0,
                  letterSpacing: -1.08,
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: 190,
              child: Text(
                '아래 약관에 모두 동의해주세요',
                style: TextStyle(
                        color: Color(0xFF747A8B),
                        fontSize: 17,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w300,
                        height: 0.08,
                        letterSpacing: -0.51,
                      ),
              ),
            ),
            Positioned(
              left: 20,
              top:410,
              child: Container(
                        width: MediaQuery.of(context).size.width - 40, // 적절한 너비 지정
                        height: 400,
                        child: Column(children: [
                          CheckboxListTile(
                            title: Text('모든 약관에 동의합니다', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Pretendard',
                              color: Color(0xFF1F222B),
                              )),
                            value: isAllChecked,
                            onChanged: _handleAllChecked,
                            activeColor: Colors.blue,
                          ),
                          Divider(
                            color: Color(0xffD7DDED), // 구분선 색상 설정
                            thickness: 1, // 구분선 두께 설정
                            height: 5, // 구분선의 상하 여백 설정
                          ),
                          CheckboxListTile(
                            title: Text('서비스 이용약관에 동의합니다', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Pretendard',
                              color: Color(0xFF1F222B),
                              )),
                            value: isItem1Checked,
                            activeColor: Colors.blue,
                            onChanged: (bool? value) {
                              _handleItemChanged(value, 1);
                            },
                          ),
                          
                          CheckboxListTile(
                            title: Text('개인정보 처리방침에 동의합니다', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Pretendard',
                              color: Color(0xFF1F222B),
                              )),
                            
                            value: isItem2Checked,
                            activeColor: Colors.blue,
                            onChanged: (bool? value) {
                              _handleItemChanged(value, 2);
                            },
                          ),
                          SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () {
                              if ( isAllChecked ) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  
                                      '/register',
                                      (Route<dynamic> route) => false);
                              } else {
                                _showMessageDialog('모든 약관에 동의해주세요');

                              }
                              
                            },
                            child: Text(
                              "다음",
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
                        ])),
            )
          ]
        )
      )
      )
    );
  }
}