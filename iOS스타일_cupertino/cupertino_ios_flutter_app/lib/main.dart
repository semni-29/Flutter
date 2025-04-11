import 'package:flutter/material.dart';

import 'animalItem.dart'; // 동물 데이터 클래스
import 'sub/firstPage.dart'; // 첫 번째 탭 페이지
import 'sub/secondPage.dart'; // 두 번째 탭 페이지

void main() {
  runApp(const MyApp());
}

/// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true, // Material 3 사용
        colorSchemeSeed: Colors.blue, // 앱 전반의 색상 테마 설정
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/// 홈 페이지 위젯 (Stateful)
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController controller; // 탭 컨트롤러
  final List<Animal> animalList = []; // 동물 리스트

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    // 동물 객체 초기화
    animalList.addAll([
      Animal(animalName: "벌", kind: "곤충", imagePath: "repo/images/bee.png"),
      Animal(animalName: "고양이", kind: "포유류", imagePath: "repo/images/cat.png"),
      Animal(animalName: "젖소", kind: "포유류", imagePath: "repo/images/cow.png"),
      Animal(animalName: "강아지", kind: "포유류", imagePath: "repo/images/dog.png"),
      Animal(animalName: "여우", kind: "포유류", imagePath: "repo/images/fox.png"),
      Animal(animalName: "원숭이", kind: "영장류", imagePath: "repo/images/monkey.png"),
      Animal(animalName: "돼지", kind: "포유류", imagePath: "repo/images/pig.png"),
      Animal(animalName: "늑대", kind: "포유류", imagePath: "repo/images/wolf.png"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Example'),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          FirstApp(list: animalList), // 첫 번째 탭 내용
          SecondApp(list: animalList), // 두 번째 탭 내용
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: controller,
        tabs: const <Tab>[
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // 컨트롤러 메모리 해제
    super.dispose();
  }
}
