import 'package:flutter/material.dart';

// 앱의 진입점
void main() => runApp(const MyApp());

// MyApp은 StatefulWidget을 상속받아 상태를 가질 수 있음
class MyApp extends StatefulWidget {
  const MyApp({super.key}); // 최신 버전에서는 const 생성자 사용 권장

  @override
  State<MyApp> createState() {
    print('createState');
    return _MyAppState();
  }
}

// 실제 상태를 담당하는 클래스
class _MyAppState extends State<MyApp> {
  bool switchValue = false; // 토글 상태를 저장
  String test = 'hello';    // 버튼 텍스트
  Color _color = Colors.blue; // 버튼 배경색

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber, // 메인 색상 설정
      ),
      darkTheme: ThemeData.light(),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            // 텍스트 크기 및 스타일 추가
            style: ElevatedButton.styleFrom(
              backgroundColor: _color, // 버튼 배경색
              foregroundColor: _color == Colors.blue ? Colors.white : Colors.black, // 텍스트 색상 조건부 설정
              textStyle: const TextStyle(fontSize: 30), // 텍스트 크기 30
            ),
            onPressed: () {
              setState(() {
                // 상태 변경
                test = 'flutter';
                _color = (_color == Colors.blue) ? Colors.amber : Colors.blue;
              });
            },
            child: Text(test), // 버튼 텍스트
          ),
        ),
      ),
    );
  }
}
