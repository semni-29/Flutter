import 'package:flutter/material.dart';

import 'sub/firstPage.dart';
import 'sub/secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  // TabBar 및 TabBarView를 제어할 컨트롤러 선언
  late TabController controller;

  @override
  void initState() {
    super.initState();

    // TabController 초기화: 탭의 수는 2개, vsync는 애니메이션을 위한 필수 요소
    controller = TabController(length: 2, vsync: this);

    // 탭 변경 시 이벤트 감지 리스너 등록
    controller.addListener(() {
      if (!controller.indexIsChanging) {
        // 사용자가 탭을 변경한 후의 상태 출력
        print("이전 index: ${controller.previousIndex}");
        print("현재 index: ${controller.index}");
        print("전체 탭 길이: ${controller.length}");
      }
    });
  }

  @override
  void dispose() {
    // TabController 메모리 누수 방지를 위해 dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Example'),
      ),

      // 탭별로 보여줄 화면들을 정의하는 위젯
      body: TabBarView(
        controller: controller, // TabController와 연결
        children: const <Widget>[
          FirstApp(),  // 첫 번째 탭에 해당하는 화면
          SecondApp(), // 두 번째 탭에 해당하는 화면
        ],
      ),

      // 하단 네비게이션 영역에 TabBar 배치
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.surface,
        child: TabBar(
          controller: controller, // 같은 컨트롤러로 TabBarView와 연동
          tabs: const <Tab>[
            // 첫 번째 탭: 숫자 1 아이콘
            Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),

            // 두 번째 탭: 숫자 2 아이콘
            Tab(icon: Icon(Icons.looks_two, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
