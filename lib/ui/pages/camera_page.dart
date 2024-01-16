
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pickar_app/blocs/auth_bloc.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {


  
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color(0xFFFEFEFE),
    );
  }

  @override
  Widget build(BuildContext context) {
    Route _routePage(Widget targetPage) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      );
    }

    return Scaffold(
      appBar: _appbarWidget(),
      backgroundColor: Colors.black87,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // 배경으로 사용할 이미지
          Image.asset(
            'assets/images/pklot.jpeg', // 여기에 이미지 파일 경로를 넣으세요.
            fit: BoxFit.fitWidth,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          CustomPaint(
              size: Size(200, 100), // 윤곽선의 크기 조절
              painter: CarOutlinePainter(),
            ),
          // 카메라 UI 요소들
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () {
                  // 셔터 버튼 기능 구현
                },
                child: Icon(Icons.camera),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// 자동차 윤곽선을 그리기 위한 CustomPainter 클래스
class CarOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // 자동차 윤곽선을 그리는 로직
    // 예시로 간단한 직선만 그립니다. 실제 윤곽선은 복잡할 수 있음
    // canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    // 여기에 추가적인 그리기 로직을 넣으세요.
    // 차체 윤곽선 그리기
    var path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.7); // 시작점
    path.lineTo(size.width * 0.2, size.height * 0.5); // 앞 유리
    path.lineTo(size.width * 0.4, size.height * 0.3); // 지붕
    path.lineTo(size.width * 0.8, size.height * 0.3); // 지붕 뒤
    path.lineTo(size.width * 0.9, size.height * 0.5); // 뒷 유리
    path.lineTo(size.width * 0.9, size.height * 0.7); // 후면
    path.lineTo(size.width * 0.2, size.height * 0.7); // 차체 바닥선
    canvas.drawPath(path, paint);

    // 바퀴 그리기
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.7), size.height * 0.1, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.7), size.height * 0.1, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}