/* #StatefulWidget : 시간에 따라 바뀌는 UI를 만들 때 사용됨. 내부 상태(state)를 갖고 있고, 상태가 바뀔 때마다 자동으로 UI가 다시 그려집니다.
   - 특징: 1) 내부에 상태 변수 존재
          2) setState()를 사용해 UI 업데이트
          3) 유저 입력, 애니메이션, 네트워크 요청 결과 등 처리 가능
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
            child: Switch(value: switchValue,
                          onChanged: (value) {print(value);
                                              setState(() {switchValue = value;});
                                             }
                          ),
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
