
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pickar_app/blocs/image_processing_bloc.dart';

class ServicePage extends StatefulWidget {

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool _isLoading = false;
  XFile? _inputImage;

  Future getImage() async {
    
    setState(() {
      _inputImage = null;
      _isLoading = true;
    });
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // 이미지 용량을 낮추기
      XFile compressedFile = await compressImage(pickedFile.path, 50);

      setState(() {
        _inputImage = compressedFile;
        _isLoading = false;
        
      });
    }
  }

  Future<XFile> compressImage(String path, int quality) async {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      path,
      path.replaceFirst('.jpg', '_compressed.jpg'),
      quality: quality,
    );

    return compressedImage!;
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 15, right: 15, top:15),
          child: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: 
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        getImage();
        
                      },
                      child: Container(
                        height: 300,
                        decoration: 
                          BoxDecoration(
                            color: _inputImage == null
                              ? Color(0xffE4EBF6)
                              :Colors.transparent,
                            
                            borderRadius: BorderRadius.circular(7),
                          ),
                        child: Center(
                          child: _inputImage == null
                            ? Icon(Icons.add, size: 50,)
                            : Image.file(
                              File(_inputImage!.path),
                              width: MediaQuery.of(context).size.width, 
                              height: 300, 
                              fit:BoxFit.fill)
                            
                          ),
                              
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                            color: Color(0xffD7DDED), // 구분선 색상 설정
                            thickness: 1, // 구분선 두께 설정
                            height: 5, // 구분선의 상하 여백 설정
                          ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE4EBF6),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color:  Color(0xffF2F4F5),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  
                                ),
                                
                              ],
                          ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                              color: Color(0xffD7DDED), // 구분선 색상 설정
                              thickness: 1, // 구분선 두께 설정
                              height: 5, // 구분선의 상하 여백 설정
                            ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async{
                          if (_inputImage?.path != null ) {
                            String convertedImage = await imageProcessingBloc.getImageCaption(_inputImage!.path);
                            print(convertedImage);
                          } else {
                            _showMessageDialog('이미지를 선택해주세요!');
                          }
                        },
                        child: Text(
                          "이모지 만들기",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Color(0xff64b9b2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            shadowColor: Colors.black),
                      ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}