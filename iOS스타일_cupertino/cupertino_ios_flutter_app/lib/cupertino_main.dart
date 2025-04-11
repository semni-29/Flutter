import 'package:flutter/cupertino.dart';

import 'animalItem.dart';
import 'iosSub/cupertinoFirstPage.dart';
import 'iosSub/cupertinoSecondPage.dart';


void main() {
  runApp(const CupertinoMain());
}


// 전역으로 선언된 즐겨찾기 리스트
List<Animal> favoriteList = List.empty(growable: true);

class CupertinoMain extends StatefulWidget {
  const CupertinoMain({super.key});

  @override
  State<CupertinoMain> createState() => _CupertinoMain();
}

class _CupertinoMain extends State<CupertinoMain> {
  late final CupertinoTabBar tabBar; // Cupertino 하단 탭바
  final List<Animal> animalList = List.empty(growable: true); // 동물 리스트

  @override
  void initState() {
    super.initState();

    // Cupertino 스타일 하단 네비게이션 바 초기화
    tabBar = CupertinoTabBar(
      items: [
        const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
        const BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
      ],
    );

    // 예시용 동물 데이터 추가
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
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: tabBar, // 하단 탭 바 적용
        tabBuilder: (context, index) {
          // 탭 인덱스에 따라 다른 페이지 반환
          if (index == 0) {
            return CupertinoFirstPage(animalList: animalList); // 첫 번째 페이지
          } else {
            return CupertinoSecondPage(animalList: animalList); // 두 번째 페이지
          }
        },
      ),
    );
  }
}
