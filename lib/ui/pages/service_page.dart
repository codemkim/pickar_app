
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ServicePage extends StatefulWidget {

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool _isLoading = false;

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

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ],
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: LoadingOverlay(
        isLoading: _isLoading,
        opacity: 0.5,
        progressIndicator: LoadingAnimationWidget.staggeredDotsWave(
              color: Color(0xff64b9b2), size: 50),
        child: NaverMap(
          options: const NaverMapViewOptions(),
          onMapReady: (controller) {
            print("네이버 맵 로딩됨!");
          },
        )
      ),
    );
  }
}