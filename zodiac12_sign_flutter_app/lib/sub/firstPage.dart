import 'package:flutter/material.dart';
import '../animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal> list;
  const FirstApp({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      list[index].imagePath!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      list[index].animalName!,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text(
                      '이 동물은 <${list[index].kind}> 입니다.',
                      style: const TextStyle(fontSize: 30.0),
                    ),
                  ),
                );
              },
              onLongPress: () {
                // 롱프레스 시 삭제: StatefulWidget이 아니기 때문에 별도 상태처리는 필요함
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('삭제 기능은 상태 관리가 필요합니다.')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
