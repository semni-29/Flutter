import 'package:flutter/material.dart';
import 'people.dart';  // People 클래스를 위한 파일
import 'secondPage.dart';  // 두 번째 페이지로 이동하기 위한 파일

import 'intro.dart';
import 'sliverPage.dart';

void main() => runApp(const MyApp());  // MyApp을 실행

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',  // 앱의 제목
      theme: ThemeData(
        primarySwatch: Colors.blue,  // 기본 색상 설정
      ),
      home: const IntroPage(),  // 앱의 첫 번째 페이지로 IntroPage를 설정
    );
  }
}

class AnimationApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationApp();
}

class _AnimationApp extends State<AnimationApp> {
  List<People> peoples = List.empty(growable: true);  // 사람들의 데이터를 저장할 리스트
  int current = 0;  // 현재 사람 인덱스
  Color weightColor = Colors.blue;  // 몸무게에 따라 바뀌는 색상
  double _opacity = 1;  // 애니메이션을 위한 투명도 값

  @override
  void initState() {
    super.initState();
    // 여러 사람들의 정보를 리스트에 추가
    peoples.add(People('스미스', 180, 92));
    peoples.add(People('메리', 162, 55));
    peoples.add(People('존', 177, 75));
    peoples.add(People('바트', 130, 40));
    peoples.add(People('콘', 194, 140));
    peoples.add(People('디디', 100, 80));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),  // 앱바 제목
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // 중앙 정렬
          children: <Widget>[
            // 애니메이션을 적용할 위젯
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(width: 100, child: Text('이름 : ${peoples[current].name}')),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.bounceIn,
                      color: Colors.amber,
                      width: 50,
                      height: peoples[current].height,
                      child: Text(
                        '키 ${peoples[current].height}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInCubic,
                      color: weightColor,
                      width: 50,
                      height: peoples[current].weight,
                      child: Text(
                        '몸무게 ${peoples[current].weight}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.linear,
                      color: Colors.pinkAccent,
                      width: 50,
                      height: peoples[current].bmi,
                      child: Text(
                        'BMI ${peoples[current].bmi.toStringAsFixed(1)}',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // 다음 버튼
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (current < peoples.length - 1) {
                    current++;
                  }
                  _changeWeightColor(peoples[current].weight);
                });
              },
              child: const Text('다음'),
            ),
            // 이전 버튼
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (current > 0) {
                    current--;
                  }
                  _changeWeightColor(peoples[current].weight);
                });
              },
              child: const Text('이전'),
            ),
            // 사라지기 버튼 (애니메이션 효과)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _opacity = _opacity == 1 ? 0 : 1;
                });
              },
              child: const Text('사라지기'),
            ),
            // SecondPage로 이동
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: SizedBox(
                width: 160,
                child: Row(
                  children: const <Widget>[
                    Hero(tag: 'detail', child: Icon(Icons.cake)),
                    Text('로테이션 페이지로 이동'),
                  ],
                ),
              ),
            ),

            // SliverPage로 이동하는 버튼 추가
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SliverPage()),
                );
              },
              child: const Text('Sliver 페이지로 이동'),
            ),
          ],
        ),
      ),
    );
  }

  // 몸무게에 따라 색상 변경
  void _changeWeightColor(double weight) {
    if (weight < 40) {
      weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      weightColor = Colors.indigo;
    } else if (weight < 80) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }
}