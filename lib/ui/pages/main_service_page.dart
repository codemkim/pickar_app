import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:pickar_app/blocs/auth_bloc.dart';
import 'package:pickar_app/social/social_login.dart';
import 'package:pickar_app/ui/pages/service_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainServicePage extends StatefulWidget {
  const MainServicePage({super.key});

  @override
  State<MainServicePage> createState() => _MainServicePageState();
}

class _MainServicePageState extends State<MainServicePage> {

  final PageController _pageController = PageController();
  SharedPreferences? prefs;
  late bool _isGeolocatorEnabled;
  bool _isPageEvent = false;
  Timer? _timer;

  @override
  void initState() {

    Future.delayed(Duration(microseconds: 100), () async {
      LocationPermission permission;
    
      _isGeolocatorEnabled = await Geolocator.isLocationServiceEnabled();

      if (!_isGeolocatorEnabled) {
        // 위치 서비스를 활성화하도록 요청
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // 권한이 거부된 경우 처리
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // 권한이 영구적으로 거부된 경우 처리
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      } 
      // 현재 위치 얻기
      Position initPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print('initPosition====${initPosition}');

      prefs = await SharedPreferences.getInstance();
      print("loading shared preferences");
      prefs?.setDouble('currentLatitude', initPosition.latitude);
      prefs?.setDouble('currentLongitude', initPosition.longitude);

      print(prefs?.getDouble('currentLatitude'));
      print(prefs?.getDouble('currentLongitude'));

    });


    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage >= 5) nextPage = 0;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
  }



  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 30,)),
      backgroundColor: Color(0xFFFEFEFE),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none, size: 30,)),
        IconButton(onPressed: () async{

          await authBloc.logout();

        }, icon: Icon(Icons.logout,)),
        
      ],
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
      body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
            // 
            if (_isPageEvent) {
              _startAutoScroll();
              _isPageEvent = true;
            }
          },
          child: 
            SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    color: Color(0xFFFEFEFE),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xffE4EBF6),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color:  Color(0xffF2F4F5),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 200,
                          // padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, _routePage(ServicePage()));
                                },
                                child: Container(
                                  
                                  width: (MediaQuery.of(context).size.width/2) - 25,
                                  decoration: BoxDecoration(
                                    color:  Color(0xFFF0F8FF),
                                    borderRadius: BorderRadius.circular(7),
                                    // border: Border.all(color: Colors.black, width: 1)
                                  
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        left: 10,
                                        child: Lottie.asset('assets/animations/pick_1_park.json',width: 150, height: 150)
                                        ),
                                      Positioned(
                                        bottom: 17,
                                        left: 30,
                                        child: Column(
                                          children: [
                                            Text(
                                              '주차구역 확인하고',
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                            ),
                                            Text(
                                              '공유 하기',
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                            )
                                        ],)
                                      ),
                                    ],
                                  ),
                                
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, _routePage(ServicePage()));
                                },
                                child: Container(
                                  width: (MediaQuery.of(context).size.width/2) - 25,
                                  decoration: BoxDecoration(
                                    color:  Color(0xff162d4c),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Stack(
                                      children: [
                                        Lottie.asset('assets/animations/find_park.json'),
                                        Positioned(
                                          bottom: 20,
                                          left: 25,
                                          child: Column(
                                            children: [
                                              Text(
                                                '내주변 가장 가까운 ',
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                              ),
                                              Text(
                                                '주차 공간',
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                              )
                                          ],)
                                        ),
                                      ],
                                    ),
                                  
                                
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 70,

                          color:Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                                _stopAutoScroll();
                                _isPageEvent = true;
                                // 여기에 Content 1이 클릭되었을 때의 로직을 추가하세요.
                              },
                            child: PageView(
                              controller: _pageController, 
                              children: [
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 8), // 카드 사이의 간격
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2F4F5),
                                    borderRadius: BorderRadius.circular(8), // 둥근 모서리
                                  ),
                                  child: Center(
                                    child: Text('content1'),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 8), // 카드 사이의 간격
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2F4F5),
                                    borderRadius: BorderRadius.circular(8), // 둥근 모서리
                                  ),
                                  child: Center(
                                    child: Text('content2'),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 8), // 카드 사이의 간격
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2F4F5),
                                    borderRadius: BorderRadius.circular(8), // 둥근 모서리
                                  ),
                                  child: Center(
                                    child: Text('content3'),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 8), // 카드 사이의 간격
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2F4F5),
                                    borderRadius: BorderRadius.circular(8), // 둥근 모서리
                                  ),
                                  child: Center(
                                    child: Text('content3'),
                                  ),
                                ),
                                Container(
                            
                                  height: 40,
                                  margin: EdgeInsets.symmetric(horizontal: 8), // 카드 사이의 간격
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2F4F5),
                                    borderRadius: BorderRadius.circular(8), // 둥근 모서리
                                  ),
                                  child: Center(
                                    child: Text('content4'),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF2F4F5),
                                    borderRadius: BorderRadius.circular(8), // 둥근 모서리
                                  ),
                                  child: Center(
                                    child: Text('content5'),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // 인디케이터와 카드 사이의 간격
                        SmoothPageIndicator(
                          controller: _pageController,  // PageController를 전달합니다.
                          count:  5,  // 페이지의 총 수입니다.
                          effect: const WormEffect(
                            dotColor: Color(0xffF2F4F5),
                            activeDotColor: Color(0xffA2A4A9),
                            dotHeight: 10,
                            dotWidth: 10,
                            type: WormType.normal,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 100,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // height: 100,
                                // padding: EdgeInsets.all(10), // 내용과 테두리 사이의 간격
                                width: (MediaQuery.of(context).size.width/2) - 25,
                                decoration: BoxDecoration(
                                  color:  Color(0xffF2F4F5),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                // child: IconButton(
                                //   onPressed: () {},
                                  
                                //   icon: Icon(Icons.help)
                                //   ),

                              ),
                              Container(
                                padding: EdgeInsets.all(16), // 내용과 테두리 사이의 간격
                                width: (MediaQuery.of(context).size.width/2) - 25,
                                decoration: BoxDecoration(
                                  color:  Color(0xffF2F4F5),
                                  borderRadius: BorderRadius.circular(7),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
          ),
    );
  }
}