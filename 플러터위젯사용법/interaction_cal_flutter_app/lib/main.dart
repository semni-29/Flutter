import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  const WidgetApp({super.key});

  @override
  State<WidgetApp> createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp> {
  final List<String> _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = [];
  String? buttonText;
  String sum = '';
  final TextEditingController value1 = TextEditingController();
  final TextEditingController value2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(
        DropdownMenuItem(value: item, child: Text(item)),
      );
    }
    buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                '결과 : $sum',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value1,
                decoration: const InputDecoration(
                  labelText: '첫 번째 숫자',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value2,
                decoration: const InputDecoration(
                  labelText: '두 번째 숫자',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    double value1Int = double.tryParse(value1.text) ?? 0;
                    double value2Int = double.tryParse(value2.text) ?? 0;
                    double result;

                    switch (buttonText) {
                      case '더하기':
                        result = value1Int + value2Int;
                        break;
                      case '빼기':
                        result = value1Int - value2Int;
                        break;
                      case '곱하기':
                        result = value1Int * value2Int;
                        break;
                      case '나누기':
                        result = value2Int != 0 ? value1Int / value2Int : 0;
                        break;
                      default:
                        result = 0;
                    }
                    sum = result.toString();
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Icons.calculate),
                    const SizedBox(width: 8),
                    Text(buttonText ?? ''),
                  ],
                ),
              ),
            ),ㅊ
            Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButton<String>(
                items: _dropDownMenuItems,
                onChanged: (String? value) {
                  setState(() {
                    buttonText = value;
                  });
                },
                value: buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
