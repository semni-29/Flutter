import 'package:flutter/material.dart';
import 'largeFileMain.dart'; // 대용량 파일 다운로드 화면 import

void main() {
  runApp(const MyApp());
}

// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Large File Downloader', // 앱 이름
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Material 3 스타일 사용
      ),
      home: const LargeFileMain(), // 시작 페이지로 대용량 다운로드 화면 설정
    );
  }
}
