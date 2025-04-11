import 'package:flutter/material.dart';
import '../animalItem.dart';

/// 첫 번째 탭에 보여질 리스트 화면
class FirstApp extends StatelessWidget {
  /// 전달받은 동물 리스트
  final List<Animal> list;

  const FirstApp({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: list.length, // 리스트 개수
          itemBuilder: (context, position) {
            final animal = list[position]; // 현재 동물 객체

            return GestureDetector(
              onTap: () {
                // 탭 시 다이얼로그 표시
                final dialog = AlertDialog(
                  content: Text(
                    '이 동물은 ${animal.kind} 입니다',
                    style: const TextStyle(fontSize: 30.0),
                  ),
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) => dialog,
                );
              },
              onLongPress: () {
                // 길게 누르면 해당 항목 삭제
                list.removeAt(position);
              },
              child: Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      // 동물 이미지
                      Image.asset(
                        animal.imagePath,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 16),
                      // 동물 이름 텍스트
                      Text(
                        animal.animalName,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
