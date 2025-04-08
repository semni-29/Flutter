//1개의 위젯 만들기 (child 사용)
import 'package:flutter/material.dart';

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
      home: MaterialFlutterApp()    // 앱이 시작될 때 보여줄 첫 번째 화면(홈 화면)을 지정함.
    );
  }
}


// MaterialFlutterApp은 상태가 변할 수 있는 StatefulWidget임.
class MaterialFlutterApp extends StatefulWidget {
  const MaterialFlutterApp({super.key});

  // 실제 상태를 관리하는 클래스(_MaterialFlutterApp)를 생성함.
  @override
  State<StatefulWidget> createState() {
    return _MaterialFlutterApp();
  }
}

// _MaterialFlutterApp은 MaterialFlutterApp 위젯의 상태를 관리함.
class _MaterialFlutterApp extends State<MaterialFlutterApp>{
  @override
  Widget build(BuildContext context){
    // Scaffold는 머티리얼 디자인 앱의 기본 레이아웃 구조를 제공.
    return Scaffold(
      appBar: AppBar(title: Text('Material Design App'),),   // 앱 상단에 표시될 앱바(헤더)를 설정함.
      floatingActionButton: FloatingActionButton(           // 화면에 떠 있는 동그란 버튼을 추가 .
          child: Icon(Icons.add), //오른쪽 하단에 +(add) 버튼 표시
          onPressed: (){  }       // 버튼이 눌렸을 때 실행될 코드 작성 부분(현재 비어있음)
      ),
    );
  }
}


/*
<main.dart의 위젯구조도>

Scaffold
├── body
│   └── Container
├── AppBar
│   └── Text
└── FloatingActionButton
    └── Icon
 */


/*
  • StatelessWidget: 상태를 가지지 않는, 고정된 UI를 위한 클래스
  • StatefulWidget: 상태를 가질 수 있는, 동적으로 변할 수 있는 UI를 위한 클래스
  • Scaffold: 앱의 기본 레이아웃 구조 (앱바, 바디, 버튼 등 포함 가능)
  • AppBar: 상단 헤더
  • FloatingActionButton: 둥둥 떠있는 액션 버튼
 */