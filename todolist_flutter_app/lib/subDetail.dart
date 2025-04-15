import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  const SubDetail({super.key});

  @override
  State<SubDetail> createState() => _SubDetailState();
}

class _SubDetailState extends State<SubDetail> {
  // 할 일 목록 리스트 (동적으로 추가 가능)
  final List<String> todoList = [];

  @override
  void initState() {
    super.initState();
    // 초기 할 일 항목 추가
    todoList.addAll([
      '당근 사오기',
      '약 사오기',
      '청소하기',
      '부모님께 전화드리기',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(
                todoList[index],
                style: const TextStyle(fontSize: 20),
              ),
              onTap: () {
                // 아이템 클릭 시 third 페이지로 이동하면서 데이터 전달
                Navigator.of(context).pushNamed(
                  '/third',
                  arguments: todoList[index],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNavigation(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // '/second' 라우트로 이동 후 결과 받아오기
  Future<void> _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second'); //스택 메모리에 있는 자료를 교체하는 코드

    // null이 아닌 경우 리스트에 추가
    if (result != null && result is String) {
      setState(() {
        todoList.add(result);
      });
    }
  }
}
