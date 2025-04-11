import 'package:flutter/material.dart';

// 두 번째 탭에서 사용되는 2번 화면
class SecondApp extends StatelessWidget {
  const SecondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(      // Scaffold는 기본적인 앱 레이아웃 구조 제공
      body: Center(
        child: Text('두 번째 페이지'),
      ),
    );
  }
}