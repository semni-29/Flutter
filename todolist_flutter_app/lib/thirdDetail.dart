import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  const ThirdDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // ModalRoute에서 전달받은 arguments 안전하게 처리
    final args = ModalRoute.of(context)?.settings.arguments;
    final String message = (args is String) ? args : '데이터가 없습니다';

    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 상세 보기'),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
