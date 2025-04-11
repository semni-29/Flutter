import 'package:flutter/material.dart';
import '../animalItem.dart';

/// 동물 추가 탭을 나타내는 Stateful 위젯
class SecondApp extends StatefulWidget {
  final List<Animal> list;

  const SecondApp({Key? key, required this.list}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  int _radioValue = 0; // 선택된 라디오 버튼 값
  final TextEditingController nameController = TextEditingController(); // 이름 입력 필드
  bool flyExist = false; // 날 수 있는지 여부
  String? _imagePath; // 선택된 이미지 경로

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView( // 스크롤 가능하게 개선
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 동물 이름 입력 필드
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: '동물 이름',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // 동물 종류 선택 라디오 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange),
                  const Text('양서류'),
                  Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
                  const Text('파충류'),
                  Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
                  const Text('포유류'),
                ],
              ),

              const SizedBox(height: 20),

              // 날 수 있는지 여부 체크박스
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('날 수 있나요?'),
                  Checkbox(
                    value: flyExist,
                    onChanged: (bool? check) {
                      setState(() {
                        flyExist = check ?? false;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 이미지 선택 가로 스크롤 리스트
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildImageSelector('repo/images/cow.png'),
                    _buildImageSelector('repo/images/pig.png'),
                    _buildImageSelector('repo/images/bee.png'),
                    _buildImageSelector('repo/images/cat.png'),
                    _buildImageSelector('repo/images/fox.png'),
                    _buildImageSelector('repo/images/monkey.png'),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 동물 추가 버튼
              ElevatedButton(
                onPressed: _imagePath == null || nameController.text.trim().isEmpty
                    ? null // 이름이나 이미지가 없으면 버튼 비활성화
                    : () => _showAddDialog(context),
                child: const Text('동물 추가하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 라디오 버튼 변경 핸들러
  void _radioChange(int? value) {
    setState(() {
      _radioValue = value ?? 0;
    });
  }

  /// 동물 종류 문자열 반환
  String getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
      default:
        return "기타";
    }
  }

  /// 이미지 선택 위젯 생성
  Widget _buildImageSelector(String path) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _imagePath = path;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: _imagePath == path ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Image.asset(path, width: 80),
      ),
    );
  }

  /// 동물 추가 확인 다이얼로그 표시
  void _showAddDialog(BuildContext context) {
    final animal = Animal(
      animalName: nameController.text,
      kind: getKind(_radioValue),
      imagePath: _imagePath!,
      flyExist: flyExist,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('동물 추가하기'),
          content: Text(
            '이 동물은 ${animal.animalName}입니다.\n'
                '종류는 ${animal.kind}이고, 날 수 ${animal.flyExist ? "있습니다" : "없습니다"}.\n'
                '추가하시겠습니까?',
            style: const TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.list.add(animal); // 리스트에 추가
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('예'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('아니요'),
            ),
          ],
        );
      },
    );
  }
}
