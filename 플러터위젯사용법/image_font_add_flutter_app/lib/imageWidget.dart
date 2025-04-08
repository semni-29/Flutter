import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImgWidgetApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _ImgWidgetApp();
  }
}

class _ImgWidgetApp extends State<ImgWidgetApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Image Widget'),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('image/malsoon.PNG', width: 300, height: 270, fit: BoxFit.fill),
              Text('오말순', style: TextStyle(fontFamily: 'Giants', fontSize: 50, color: Colors.blueAccent),)
            ],
          ),
        ),
      ),
    );
  }
}