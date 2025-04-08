//이미지와 폰트 추가하기

import 'package:flutter/material.dart';
import 'imageWidget.dart';

void main() {
  runApp(const MyApp());   // runApp()는 위젯을 화면에 출력하는 역할
}

// MyApp은 전체 앱의 뼈대를 구성하는 StatelessWidget임.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 앱의 UI를 정의하는 메서드.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImgWidgetApp()    // 앱이 시작될 때 보여줄 첫 번째 화면(홈 화면)을 지정함.
    );
  }
}
