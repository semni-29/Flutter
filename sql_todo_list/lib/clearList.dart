import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sql_example/todo_sql.dart';

class ClearListApp extends StatefulWidget {
  final Future<Database> database;

  const ClearListApp(this.database, {super.key});

  @override
  State<ClearListApp> createState() => _ClearListAppState();
}

class _ClearListAppState extends State<ClearListApp> {
  // 완료된 Todo 목록을 저장하는 Future
  late Future<List<Todo>> clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList(); // 완료된 목록 불러오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미 한 일'),
      ),
      body: Center(
        child: FutureBuilder<List<Todo>>(
          future: clearList,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator(); // 로딩 중
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('완료된 할 일이 없습니다.');
            }

            // 완료된 할 일이 있을 때 리스트 표시
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final todo = snapshot.data![index];
                return ListTile(
                  title: Text(
                    todo.title ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(todo.content ?? ''),
                      const SizedBox(height: 8),
                      Container(height: 1, color: Colors.blue),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('완료한 일 삭제'),
                content: const Text('완료한 일을 모두 삭제할까요?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('예'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('아니요'),
                  ),
                ],
              );
            },
          );

          if (result == true) {
            _removeAllTodos(); // 완료된 할 일 모두 삭제
          }
        },
        tooltip: '완료한 일 모두 삭제',
        child: const Icon(Icons.remove),
      ),
    );
  }

  // 완료된 할 일 목록을 데이터베이스에서 조회
  Future<List<Todo>> getClearList() async {
    final db = await widget.database;
    final maps = await db.rawQuery(
        'SELECT title, content, id FROM todos WHERE active = 1');

    return List.generate(maps.length, (i) {
      return Todo(
        title: maps[i]['title'] as String?,
        content: maps[i]['content'] as String?,
        id: maps[i]['id'] as int?,
        active: 1,
      );
    });
  }

  // 완료된 할 일을 모두 삭제하는 메서드
  void _removeAllTodos() async {
    final db = await widget.database;
    await db.rawDelete('DELETE FROM todos WHERE active = 1');
    setState(() {
      clearList = getClearList(); // 삭제 후 목록 다시 로딩
    });
  }
}
