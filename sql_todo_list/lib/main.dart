import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'addTodo.dart';
import 'clearList.dart';
import 'todo_sql.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 데이터베이스 초기화
  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        // 'todos' 테이블 생성
        return db.execute(
          '''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT, 
            content TEXT, 
            active INTEGER
          )
          ''',
        );
      },
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddTodoApp(database),
        '/clear': (context) => ClearListApp(database),
      },
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  const DatabaseApp(this.db, {super.key});

  @override
  State<DatabaseApp> createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  Future<List<Todo>>? todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/clear');
              setState(() {
                todoList = getTodos();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black54, // darkgrey
            ),
            child: const Text(
              '완료한 일',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: todoList,
          builder: (context, snapshot) {
            // 데이터 로딩 상태 처리
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return const Text('No data');
            }

            // 데이터가 있을 경우 리스트로 출력
            List<Todo> todos = snapshot.data as List<Todo>;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = todos[index];
                return ListTile(
                  title: Text(
                    todo.title ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todo.content ?? ''),
                      Text('체크 : ${todo.active == 1 ? 'true' : 'false'}'),
                      const Divider(color: Colors.blue),
                    ],
                  ),
                  onTap: () async {
                    // 체크 상태 변경 다이얼로그
                    Todo result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('${todo.id} : ${todo.title}'),
                          content: const Text('Todo를 체크하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  todo.active = todo.active == 1 ? 0 : 1;
                                });
                                Navigator.of(context).pop(todo);
                              },
                              child: const Text('예'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(todo);
                              },
                              child: const Text('아니요'),
                            ),
                          ],
                        );
                      },
                    );
                    _updateTodo(result);
                  },
                  onLongPress: () async {
                    // 삭제 확인 다이얼로그
                    Todo? result = await showDialog<Todo>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('${todo.id} : ${todo.title}'),
                          content: Text('${todo.content}를 삭제하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(todo),
                              child: const Text('예'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('아니요'),
                            ),
                          ],
                        );
                      },
                    );
                    if (result != null) {
                      _deleteTodo(result);
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 추가 버튼
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
              if (todo != null && todo is Todo) {
                _insertTodo(todo);
              }
            },
            heroTag: 'add',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          // 전체 업데이트 버튼
          FloatingActionButton(
            onPressed: _allUpdate,
            heroTag: 'update',
            child: const Icon(Icons.update),
          ),
        ],
      ),
    );
  }

  // 전체 Todo를 완료 상태로 업데이트
  void _allUpdate() async {
    final db = await widget.db;
    await db.rawUpdate('UPDATE todos SET active = 1 WHERE active = 0');
    setState(() {
      todoList = getTodos();
    });
  }

  // 특정 Todo 삭제
  void _deleteTodo(Todo todo) async {
    final db = await widget.db;
    await db.delete('todos', where: 'id = ?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }

  // 특정 Todo 업데이트
  void _updateTodo(Todo todo) async {
    final db = await widget.db;
    await db.update('todos', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }

  // Todo 추가
  void _insertTodo(Todo todo) async {
    final db = await widget.db;
    await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  // DB에서 Todo 리스트 가져오기
  Future<List<Todo>> getTodos() async {
    final db = await widget.db;
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String?,
        content: maps[i]['content'] as String?,
        active: (maps[i]['active'] ?? 0) == 1 ? 1 : 0,
      );
    });
  }
}
