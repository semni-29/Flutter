import 'package:flutter/material.dart';

// 외부 페이지 import
import 'subDetail.dart';
import "thirdDetail.dart";
import 'secondDetail.dart';

void main() {
  runApp(const MyApp());
}

/// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,

      // 라이트 모드 테마 설정
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Flutter 3.19.2에서 Material3 적용
      ),

      // 다크 모드 테마 설정
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),

      initialRoute: '/', // 초기 경로 설정
      routes: {
        '/': (context) => const SubDetail(), // 홈으로 설정된 위젯
        '/second': (context) => const SecondDetail(), // 두 번째 페이지
        '/third': (context) => const ThirdDetail(), // 세 번째 페이지
      },
    );
  }
}

/// 서브 메인 페이지 위젯 (Navigator 예제 포함)
class SubMain extends StatefulWidget {
  const SubMain({super.key});

  @override
  State<SubMain> createState() => _SubMainState();
}

class _SubMainState extends State<SubMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Page Main'),
      ),
      body: const Center(
        child: Text('첫 번째 페이지'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // SecondPage로 네비게이션 이동
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SecondPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// 단순한 두 번째 페이지 위젯
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          // 이전 페이지로 돌아가기
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('돌아가기'),
        ),
      ),
    );
  }
}
