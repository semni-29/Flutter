import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const CupertinoDemoApp());
}

class CupertinoDemoApp extends StatelessWidget {
  const CupertinoDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoMainTab(),
    );
  }
}

class CupertinoMainTab extends StatelessWidget {
  const CupertinoMainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '기본'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.pencil), label: '입력'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: '컨트롤'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.time), label: '날짜/타이머'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell), label: '알림창'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const BasicTab();
          case 1:
            return const InputTab();
          case 2:
            return const ControlsTab();
          case 3:
            return const DatePickerTab();
          case 4:
            return const AlertSheetTab();
          default:
            return const BasicTab();
        }
      },
    );
  }
}

/// 1. CupertinoApp, CupertinoPageScaffold, CupertinoNavigationBar
class BasicTab extends StatelessWidget {
  const BasicTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino 기본 구조'),
      ),
      child: Center(
          child: Text('Hello!\ncupertino위젯을 이용한\n주요 iOS 스타일!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
      )
    );
  }
}

/// 2. CupertinoButton, CupertinoTextField
class InputTab extends StatelessWidget {
  const InputTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('입력 위젯'),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CupertinoTextField(
                  controller: textController,
                  placeholder: '텍스트를 입력하세요',
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: const Text('확인', style: TextStyle(color: CupertinoColors.white),),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('입력 결과'),
                        content: Text(textController.text),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('확인'),
                            onPressed: () => Navigator.pop(context),
                          )
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
}

/// 3. CupertinoSwitch, CupertinoSlider
class ControlsTab extends StatefulWidget {
  const ControlsTab({super.key});

  @override
  State<ControlsTab> createState() => _ControlsTabState();
}

class _ControlsTabState extends State<ControlsTab> {
  bool switchValue = false;
  double sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('스위치 & 슬라이더'),
      ),
      child: SafeArea(
        child: Center( // 중앙 정렬을 위한 Center 위젯 추가
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
              children: [
                const Text('스위치'),
                const SizedBox(height: 8),
                CupertinoSwitch(
                  value: switchValue,
                  onChanged: (value) => setState(() => switchValue = value),
                ),
                const SizedBox(height: 24),
                const Text('슬라이더'),
                const SizedBox(height: 8),
                CupertinoSlider(
                  value: sliderValue,
                  onChanged: (value) => setState(() => sliderValue = value),
                ),
                Text('현재 값: ${sliderValue.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// 4. CupertinoDatePicker, CupertinoTimerPicker
class DatePickerTab extends StatefulWidget {
  const DatePickerTab({super.key});

  @override
  State<DatePickerTab> createState() => _DatePickerTabState();
}

class _DatePickerTabState extends State<DatePickerTab> {
  DateTime dateTime = DateTime.now();
  Duration duration = const Duration(hours: 1);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('날짜 및 타이머'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Center(child: Text('날짜 선택기')),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: dateTime,
                onDateTimeChanged: (value) => setState(() => dateTime = value),
              ),
            ),
            const Divider(),
            const Center(child: Text('타이머 선택기')),
            SizedBox(
              height: 200,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: duration,
                onTimerDurationChanged: (value) => setState(() => duration = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 5. CupertinoActionSheet, CupertinoAlertDialog
class AlertSheetTab extends StatelessWidget {
  const AlertSheetTab({super.key});

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('경고'),
        content: const Text('이것은 경고창입니다.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('확인'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('액션 시트'),
        message: const Text('선택해주세요'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('옵션 1'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoActionSheetAction(
            child: const Text('옵션 2'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('닫기'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('알림창 예제'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text('AlertDialog', style: TextStyle(color: CupertinoColors.white),),
                onPressed: () => _showAlertDialog(context),
              ),
              const SizedBox(height: 16),
              CupertinoButton(
                color: CupertinoColors.destructiveRed,
                child: const Text('ActionSheet', style: TextStyle(color: CupertinoColors.white),),
                onPressed: () => _showActionSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}