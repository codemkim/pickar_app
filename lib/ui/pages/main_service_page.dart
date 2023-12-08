import 'package:flutter/material.dart';

class MainServicePage extends StatefulWidget {
  const MainServicePage({super.key});

  @override
  State<MainServicePage> createState() => _MainServicePageState();
}

class _MainServicePageState extends State<MainServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black38,
            padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06,
                  bottom: MediaQuery.of(context).size.height * 0.06),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  color: Colors.blueGrey,
                  // width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                      Container(
                        color: Colors.blue,
                        padding: EdgeInsets.only(right: 10),
                        margin: EdgeInsets.only(bottom: 10, left: 0),
                        width: 80,
                        height: 40,
                        child: Image.asset('assets/images/main_logo.png')
                      ),
                      Row(
                        
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.notifications)
                            ),
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.menu,)
                            )
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 150,
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    color: Colors.amber,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          color: Colors.brown,
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 150,
                          color: Colors.pink,
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 200,
                          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          color: Colors.blueAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 160,
                                color: Colors.indigoAccent,

                              ),
                              Container(
                                width: 160,
                                color: Colors.cyan,

                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 50,
                          color: Colors.green,
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 100,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
          ),
      )
    );
  }
}