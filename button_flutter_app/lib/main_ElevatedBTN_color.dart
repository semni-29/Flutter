/*
#ElevatedButton : Flutter에서 가장 자주 쓰이는 버튼 위젯 중 하나.
                  예전의 RaisedButton을 대체하는 공식 권장 버튼 위젯이고,
                  이름 그대로 "살짝 떠 있는" 느낌의 버튼이다.


*/

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return _MyApp();
  }
}

// 언더스코어(_) : 내부에서만 사용가능함을 의미함.
class _MyApp extends State<MyApp> {
  var switchValue = false;
  String test = 'hello'; //버튼에 들어갈 텍스트 입력
  Color _color = Colors.blue; // 기본 버튼 컬러 지정(blue로 지정)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.light(),
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
                child: Text('$test'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(_color),),
                onPressed: (){
                  if (_color == Colors.blue){ setState(() {test = 'flutter';
                                                            _color = Colors.amber;}); }
                  else{setState(() {test='hello';
                                    _color = Colors.blue;
                                   }
                               );}

                  })
          ),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
