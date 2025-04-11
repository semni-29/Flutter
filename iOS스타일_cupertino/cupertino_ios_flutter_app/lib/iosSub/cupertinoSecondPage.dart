import 'package:flutter/cupertino.dart';
import '../animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
  final List<Animal> animalList;

  const CupertinoSecondPage({Key? key, required this.animalList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CupertinoSecondPage();
}

class _CupertinoSecondPage extends State<CupertinoSecondPage> {
  late TextEditingController _textController; // 반드시 초기화 필요
  int _kindChoice = 0;
  bool _flyExist = false;
  String? _imagePath;

  // 세그먼트 컨트롤에 사용될 텍스트 위젯 정의
  final Map<int, Widget> segmentWidgets = const {
    0: SizedBox(width: 80, child: Text('양서류', textAlign: TextAlign.center)),
    1: SizedBox(width: 80, child: Text('포유류', textAlign: TextAlign.center)),
    2: SizedBox(width: 80, child: Text('파충류', textAlign: TextAlign.center)),
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(); // 컨트롤러 초기화
  }

  @override
  void dispose() {
    _textController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('동물 추가'), // 상단 타이틀
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 동물 이름 입력창
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CupertinoTextField(
                    controller: _textController,
                    placeholder: '동물 이름을 입력하세요',
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                  ),
                ),
                // 세그먼트 선택 (종류 선택)
                CupertinoSegmentedControl<int>(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  groupValue: _kindChoice,
                  children: segmentWidgets,
                  onValueChanged: (int value) {
                    setState(() {
                      _kindChoice = value;
                    });
                  },
                ),
                // 날 수 있는지 여부 선택
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('날개가 존재합니까?'),
                    CupertinoSwitch(
                      value: _flyExist,
                      onChanged: (bool value) {
                        setState(() {
                          _flyExist = value;
                        });
                      },
                    ),
                  ],
                ),
                // 이미지 선택 목록
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      for (final path in [
                        'repo/images/cow.png',
                        'repo/images/pig.png',
                        'repo/images/bee.png',
                        'repo/images/cat.png',
                        'repo/images/fox.png',
                        'repo/images/monkey.png',
                      ])
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _imagePath = path;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(path, width: 80),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // 동물 추가 버튼
                CupertinoButton.filled(
                  child: const Text('동물 추가하기'),
                  onPressed: () {
                    if (_textController.text.isEmpty || _imagePath == null) {
                      showCupertinoDialog(
                        context: context,
                        builder: (_) => const CupertinoAlertDialog(
                          title: Text('입력 오류'),
                          content: Text('이름과 이미지를 모두 입력해주세요.'),
                        ),
                      );
                      return;
                    }

                    final newAnimal = Animal(
                      animalName: _textController.text,
                      kind: getKind(_kindChoice),
                      imagePath: _imagePath!,
                      flyExist: _flyExist,
                    );

                    // 리스트에 추가
                    setState(() {
                      widget.animalList.add(newAnimal);
                      _textController.clear();
                      _imagePath = null;
                      _flyExist = false;
                      _kindChoice = 0;
                    });

                    showCupertinoDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: const Text('추가 완료'),
                        content: Text('${newAnimal.animalName} 이(가) 리스트에 추가되었습니다.'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('확인'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 종류 값에 따라 텍스트 반환
  String getKind(int kindChoice) {
    switch (kindChoice) {
      case 0:
        return "양서류";
      case 1:
        return "포유류";
      case 2:
        return "파충류";
      default:
        return "기타";
    }
  }
}
