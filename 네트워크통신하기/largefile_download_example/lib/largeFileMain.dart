import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// 메인 위젯
class LargeFileMain extends StatefulWidget {
  const LargeFileMain({super.key});

  @override
  State<LargeFileMain> createState() => _LargeFileMainState();
}

class _LargeFileMainState extends State<LargeFileMain> {
  bool downloading = false; // 다운로드 중 여부
  String progressString = ""; // 다운로드 진행률 표시
  String? file = ""; // 다운로드된 파일 경로
  late TextEditingController _editingController; // URL 입력 필드 컨트롤러

  @override
  void initState() {
    super.initState();
    // 기본 이미지 URL 설정
    _editingController = TextEditingController(
      text: 'https://www.motherjones.com/wp-content/uploads/2019/12/Getty121719.jpg?w=1200&h=630&crop=1',
    );
  }

  // 파일 다운로드 함수
  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      // 앱의 문서 디렉토리 가져오기
      Directory dir = await getApplicationDocumentsDirectory();

      // 다운로드 수행
      await dio.download(
        _editingController.text,
        '${dir.path}/myimage.jpg',
        onReceiveProgress: (received, total) {
          setState(() {
            downloading = true;
            progressString = '${((received / total) * 100).toStringAsFixed(0)}%';
            file = '${dir.path}/myimage.jpg';
          });
        },
      );
    } catch (e) {
      print('Download error: $e');
    }

    setState(() {
      downloading = false;
      progressString = 'Completed';
    });

    print('Download completed');
  }

  // 화면 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'URL을 입력하세요',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: downloading
        // 다운로드 중일 때 표시
            ? SizedBox(
          height: 120,
          width: 200,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  'Downloading File: $progressString',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        )
        // 다운로드가 끝나면 이미지 표시
            : FutureBuilder<Widget>(
          future: downloadWidget(file!),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('데이터 없음');
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                return snapshot.hasData
                    ? snapshot.data!
                    : const Text('데이터 없음');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: downloadFile,
        child: const Icon(Icons.file_download),
      ),
    );
  }

  // 다운로드된 이미지 표시 함수
  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    FileImage(file).evict(); // 이미지 캐시 제거

    if (exist) {
      return Center(child: Image.file(file));
    } else {
      return const Text('No Data');
    }
  }
}
