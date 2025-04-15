import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'todo_sql.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;

  const AddTodoApp(this.db, {super.key});

  @override
  State<AddTodoApp> createState() => _AddTodoAppState();
}

class _AddTodoAppState extends State<AddTodoApp> {
  // 제목과 내용 입력을 위한 컨트롤러
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    // 메모리 누수 방지를 위해 컨트롤러 해제
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 추가'),
      ),
      body: Center(
        child: SingleChildScrollView( // 키보드가 화면을 가릴 때 대비
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // 제목 입력
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                // 내용 입력
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: '할 일',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // 저장 버튼
                ElevatedButton(
                  onPressed: () {
                    // Todo 객체 생성 및 이전 화면으로 반환
                    Todo todo = Todo(
                      title: titleController.text,
                      content: contentController.text,
                      active: 0,
                    );
                    Navigator.of(context).pop(todo);
                  },
                  child: const Text('저장하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
