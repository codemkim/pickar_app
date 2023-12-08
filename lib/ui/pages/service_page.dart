
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:pickar_app/models/social_model.dart';
import 'package:pickar_app/social/social_login.dart';

class ServicePage extends StatefulWidget {

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  final socialModel = SocialModel(SocialLogin());
  
  late KakaoMapController mapController;
  bool serviceEnabled = false;
  Set<Marker> markers = {};
  
  @override
  void initState(){
    
    Future.delayed(Duration.zero, () async {
        // load shared preferences
      LocationPermission permission;
  // 위치 서비스 활성화 여부 확인
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      print('serviceEnabled=====${serviceEnabled}');
      if (!serviceEnabled) {
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
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await socialModel.logout();
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
            } 
          
          ,
           child: Text('logout')),
           SizedBox(
            width: 300,
            height: 300,
            child: KakaoMap(
              onMapCreated: ((controller) async {
                mapController = controller;
                Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
                await mapController.setCenter(LatLng(position.latitude, position.longitude));

                markers.add(Marker(
                  markerId: markers.length.toString(),
                  latLng: await mapController.getCenter(),
                  width: 30,
                  height: 44,
                  offsetX: 15,
                  offsetY: 44,
                  markerImageSrc:
                'https://w7.pngwing.com/pngs/96/889/png-transparent-marker-map-interesting-places-the-location-on-the-map-the-location-of-the-thumbnail.png',
                  ));

                setState(() {});


              }),
              onMarkerTap: ((markerId, latLng, zoomLevel) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('marker click:\n\n$latLng')));
              }),
              markers: markers.toList(),
              zoomControl: true,
              zoomControlPosition: ControlPosition.right,
              
              
            ),
           )
          ],
          )
    );
  }
}