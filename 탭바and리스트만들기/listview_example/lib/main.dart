import 'package:flutter/material.dart';
import 'animalItem.dart';
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
      title: 'listview_example_12간지',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '12간지 동물 앱'),
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
  late TabController controller;
  final List<Animal> animalList = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.addAll([
      Animal(animalName: "쥐", kind: "자(子)", imagePath: "repo/image/1_mouse.png", timeRange: "23:00 ~ 01:00"),
      Animal(animalName: "소", kind: "축(丑)", imagePath: "repo/image/2_ox.png", timeRange: "01:00 ~ 03:00"),
      Animal(animalName: "호랑이", kind: "인(寅)", imagePath: "repo/image/3_tiger.png", timeRange: "03:00 ~ 05:00"),
      Animal(animalName: "토끼", kind: "묘(卯)", imagePath: "repo/image/4_rabbit.png", timeRange: "05:00 ~ 07:00"),
      Animal(animalName: "용", kind: "진(辰)", imagePath: "repo/image/5_dragon.png", timeRange: "07:00 ~ 09:00"),
      Animal(animalName: "뱀", kind: "사(巳)", imagePath: "repo/image/6_snake.png", timeRange: "09:00 ~ 11:00"),
      Animal(animalName: "말", kind: "오(午)", imagePath: "repo/image/7_horse.png", timeRange: "11:00 ~ 13:00"),
      Animal(animalName: "양", kind: "미(未)", imagePath: "repo/image/8_goat.png", timeRange: "13:00 ~ 15:00"),
      Animal(animalName: "원숭이", kind: "신(申)", imagePath: "repo/image/9_monkey.png", timeRange: "15:00 ~ 17:00"),
      Animal(animalName: "닭", kind: "유(酉)", imagePath: "repo/image/10_rooster.png", timeRange: "17:00 ~ 19:00"),
      Animal(animalName: "개", kind: "술(戌)", imagePath: "repo/image/11_dog.png", timeRange: "19:00 ~ 21:00"),
      Animal(animalName: "돼지", kind: "해(亥)", imagePath: "repo/image/12_pig.png", timeRange: "21:00 ~ 23:00"),
    ]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('12간지(Tabbar & listview)')),
      body: TabBarView(
        controller: controller,
        children: [
          FirstApp(list: animalList),
          SecondApp(list: animalList),
        ],
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.surface,
        child: TabBar(
          controller: controller,
          tabs: const [
            Tab(icon: Icon(Icons.list)),
            Tab(icon: Icon(Icons.access_time)),
          ],
        ),
      ),
    );
  }
}
