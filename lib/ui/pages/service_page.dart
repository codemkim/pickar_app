import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_navi.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePage extends StatefulWidget {

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool _isLoading = true;
  SharedPreferences? prefs;
  LatLng currentPositon = LatLng(37.5665, 126.9780);
  Set<Marker> markers = {};
  List<CustomOverlay> customOverlays = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState(){
    _loadInitialPosition();
    var content =
        '<div style="background-color: #333333; border-radius: 8px; padding: 8px;"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70"></div>';
    final customOverlay = CustomOverlay(
      customOverlayId: 'customOverlay',
      latLng: LatLng(36.34959406739632, 127.42939112157957),
      // content: '<p style="background-color: white; padding: 8px; border-radius: 8px;">카카오!</p>',
      content: content,
    );

    customOverlays.add(customOverlay);
  }


  Future<void> _loadInitialPosition() async{
    prefs = await SharedPreferences.getInstance();

    double lat = await prefs?.getDouble('currentLatitude') ?? 37.5665;
    double lng = await prefs?.getDouble('currentLongitude') ?? 126.9780;

    setState(() {
      currentPositon = LatLng(lat, lng);
      _isLoading = false;
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
        child: Stack(
          children: [
            KakaoMap(
            zoomControl: true,
            zoomControlPosition: ControlPosition.right,
            mapTypeControl: true,
            mapTypeControlPosition: ControlPosition.topRight,
            currentLevel: 5,
            onMapTap: (point) async{
              print('point========$point');
              
          
            },
            
            onMapCreated: ((controller) async {
              
                controller.setCenter(currentPositon);
                markers.add(Marker(
                      markerId: UniqueKey().toString(),
                      latLng: LatLng(36.355973284844865,127.42969354376014),
                      width: 80,
                      height: 80,
                      markerImageSrc: 'https://image.ajunews.com/content/image/2020/07/28/20200728082128180413.jpg'
                ));
                markers.add(Marker(
                      markerId: UniqueKey().toString(),
                      latLng: LatLng(36.35195648410255,127.42396750176115),
                      width: 80,
                      height: 80,
                      markerImageSrc: 'https://sbdc.gm.go.kr/files/attach/images/203/403/014/337e9a0fcf6e80b7209d95bed98a3978.jpg'
                ));
                markers.add(Marker(
                      markerId: UniqueKey().toString(),
                      latLng: LatLng(36.343189794950256,127.42601416697995),
                      width: 80,
                      height: 80,
                      markerImageSrc: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0FQ7opX-quAZzECLxpAfWZJv5OZvDZGDZshuO1ON66XFcmUhU7tjTul1letjA-sKE4iA&usqp=CAU'
                ));
                markers.add(Marker(
                      markerId: UniqueKey().toString(),
                      latLng: LatLng(36.34885623924491,127.43406591866307),
                      width: 80,
                      height: 80,
                      markerImageSrc: 'https://upload.wikimedia.org/wikipedia/commons/1/19/Blue_Disc_Parking_Area_Markings_Blue_Paint.JPG'
                ));
                markers.add(Marker(
                      markerId: UniqueKey().toString(),
                      latLng: LatLng(36.342297927869076,127.43345028311772),
                      width: 80,
                      height: 80,
                      markerImageSrc: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRupa7YbuFqFr2fyFamItO23o4SHeyIo0iHdYKTYC0f8J94sbQuPUH1XCpNObep-lzcDps&usqp=CAU'
                ));
                setState(() { });
                print('markers ==== $markers');
              }),
            markers: markers.toList(),
            // customOverlays: customOverlays,
            
            ),
            Positioned(
              left: 120,
              bottom: 20,
              child: Container(
                height: 50,
                child: MaterialButton(
                  onPressed: () async{
                    try {
                      if (await NaviApi.instance.isKakaoNaviInstalled()) {
                        print(11111);
                      
                        await NaviApi.instance.navigate(
                          destination:
                              Location(name: '가장 가까운 주차공간', x: '127.42969354376014', y: '36.355973284844865'),
                          option: NaviOption(coordType: CoordType.wgs84),
                          // 경유지 추가
                          // viaList: [
                          //   Location(name: '판교역 1번출구', x: '127.111492', y: '37.395225'),
                          // ],
                        );
                      } else {
                        // 카카오내비 설치 페이지로 이동
                        launchBrowserTab(Uri.parse(NaviApi.webNaviInstall));
                      }
                    } catch (e) {
                      print(11111222);
                      print(e);
                    }
                  },
                  color:Colors.blueAccent,
                  child: Text(
                              "내주변 주차공간 길찾기",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                  
                ),
              ),
            )
          ]
        )
      ),
    );
  }
}