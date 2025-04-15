import 'package:flutter/material.dart';
import 'package:intro_animation_example/saturnLoading.dart';
import 'dart:async';
import 'package:intro_animation_example/main.dart'; // MainApp으로 이동을 위한 import

// IntroPage 위젯 정의
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<StatefulWidget> createState() => _IntroPage();
}

// IntroPage의 상태를 관리하는 클래스
class _IntroPage extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    // 데이터를 로드하고 일정 시간이 지나면 애니메이션 앱으로 이동
    loadData();
  }

  // 로딩 데이터를 처리하는 메소드 (5초 후에 이동)
  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 5), onDoneLoading);
  }

  // 로딩이 완료되면 호출되어 애니메이션 앱으로 이동
  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AnimationApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 전체 화면을 차지하는 레이아웃
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          children: <Widget>[
            const Text(
              '애니메이션 앱',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            // SaturnLoading 애니메이션 위젯
            SaturnLoading(),
          ],
        ),
      ),
    );
  }
}
