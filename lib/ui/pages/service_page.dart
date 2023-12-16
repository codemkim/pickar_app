
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';

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
                        onPressed: () {
                          
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