import 'package:flutter/material.dart'; //meterial_dart 패키지 호출

void main() {
  runApp(const MyApp());
  //runApp() 함수 : 플러터 앱을 시작하는 역할.
  //               이 함수에 플러터 앱을 시작하면서 화면에 표시할 위젯을 전달하는 역할
}

// MyAPP 클래스 정의
class MyApp extends StatelessWidget {
  // Stateless Widget클래스 상속받음 = 일단 상태가 변경되지 않는 위젯을 상속받았다고 생각하면 됨.
  const MyApp({super.key});

  // This widget is the root of your application.
  //MyApp클래스에서는 @override 애너테이션을 이용해 build() 함수를 재정의 함.
  @override
  Widget build(BuildContext context) { //build() : 어떠한 위젯을 만들 것인지 정의함.
    return MaterialApp(
      //MeterialApp=그림을 그리는 도화지라고 생각하면 됨.
      //MetrerialApp() 함수에는 그림을 그리는 도구에 속하는 title, theme, home 등이 정의되어 있음.
        title: 'Flutter Demo', //title : 앱 이름 지정
        theme: ThemeData( //theme : 지금 만들 앱의 테마를 어떤 색상으로 할 지 정함.
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ), //테마 컬러 설정
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),

        /*
      //(1) Text() : 화면에 텍스트를 출력하는 플러터의 기본 위젯 : 기본 구성을 호출하지 않고 home에 Text()함수를 바로 넣으면 검은색 화면(플러터의 기본 배경색)에 빨간색 글씨+노란색 밑줄로 출력됨
      home: Text('hello\nFlutter'),
      */

        /*
      //(2) Text 가운데 정렬(TextAlign.center)
        home: Text('hello\nFlutter', textAlign: TextAlign.center),
      */

        /*
      //(3) Text를 화면 정가운데 정렬
      home: Center(
        child: Text('hello\nFlutter', textAlign: TextAlign.center),
        //child : 자신 아래에 하나의 어떤 위젯을 넣겠다는 의미.
        //children : 여러 위젯을 넣고 싶을 때 사용하는 옵션
      )
      */

        /*
      //(4) 배경색상 변경 (Container : 특정 공간을 책임지는 역할을 하는 위젯. 가장 많이 사용됨)
      home: Container(
        color: Colors.white,
        child: Center(
          child: Text('hello\nFlutter', textAlign: TextAlign.center),
        )
      )
      */

        //(5) 글자색(Text color) 변경 (TextSytle 함수 사용)
        home: Container(
            color: Colors.white,
            child: Center(
              child: Text('hello\nFlutter',
                textAlign: TextAlign.center,
                style: TextStyle(color:Colors.blueAccent, fontSize: 50),),

            )
        )






    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
