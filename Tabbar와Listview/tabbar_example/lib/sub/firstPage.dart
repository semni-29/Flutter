import 'package:flutter/material.dart';

// 첫 번째 탭에서 사용되는 1번 화면
class FirstApp extends StatelessWidget {
  const FirstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('첫 번째 페이지'),
      ),
    );
  }
}
