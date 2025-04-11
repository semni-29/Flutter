import 'package:flutter/cupertino.dart';
import '../animalItem.dart';
import '../cupertino_main.dart'; // 즐겨찾기 리스트를 위한 참조

class CupertinoFirstPage extends StatelessWidget {
  final List<Animal> animalList;

  const CupertinoFirstPage({Key? key, required this.animalList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('동물 리스트'), // 상단 네비게이션 바
      ),
      child: ListView.builder(
        itemCount: animalList.length, // 리스트 항목 수
        itemBuilder: (context, index) {
          final animal = animalList[index]; // 코드 간결성을 위한 변수 추출

          return GestureDetector(
            onTap: () {
              // 아이템을 탭하면 다이얼로그 표시
              showCupertinoDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: Text(animal.animalName ?? '알 수 없음'),
                  content: Text('이 동물은 ${animal.kind ?? '알 수 없음'}입니다.'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('확인'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
            onLongPress: () {
              // 길게 누르면 즐겨찾기 리스트에 추가
              favoriteList.add(Animal(
                animalName: animal.animalName,
                kind: animal.kind,
                imagePath: animal.imagePath,
              ));

              // 추가 후 알림 표시
              showCupertinoDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: const Text('즐겨찾기 추가'),
                  content: Text('${animal.animalName} 이(가) 즐겨찾기에 추가되었습니다.'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('확인'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              height: 100,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        animal.imagePath ?? '',
                        fit: BoxFit.contain,
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 10),
                      Text(animal.animalName ?? ''),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 2,
                    color: CupertinoColors.systemGrey, // 구분선 색상 업데이트
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
