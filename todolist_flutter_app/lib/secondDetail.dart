import 'package:flutter/material.dart';

class SecondDetail extends StatelessWidget {
  const SecondDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // 텍스트 입력을 위한 컨트롤러
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 전체 여백 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              '할 일을 입력하세요',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '할 일',
                hintText: '예: Flutter 공부하기',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // 입력한 텍스트를 이전 화면으로 반환
                Navigator.of(context).pop(controller.text);
              },
              icon: const Icon(Icons.save),
              label: const Text('할 일 저장'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
