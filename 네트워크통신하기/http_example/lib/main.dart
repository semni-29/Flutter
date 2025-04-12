import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HttpApp(),
    );
  }
}

// 책 검색 기능이 포함된 Stateful 위젯
class HttpApp extends StatefulWidget {
  const HttpApp({super.key});

  @override
  State<HttpApp> createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  final TextEditingController _editingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List data = []; // 검색 결과 저장 리스트
  int page = 1; // 현재 페이지

  @override
  void initState() {
    super.initState();

    // 스크롤이 끝에 도달하면 다음 페이지 로드
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        page++;
        getJSONData(); // 다음 페이지 데이터 로드
      }
    });
  }

  @override
  void dispose() {
    _editingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Kakao Book Search API 호출 함수
  Future<void> getJSONData() async {
    final query = _editingController.text.trim();

    // 검색어가 비어있을 경우 snackbar로 알림
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('검색어를 입력하세요')),
      );
      return;
    }

    const apiKey = 'KakaoAK 00000'; // 본인의 Kakao REST API 키 사용
    final uri = Uri.https(
      'dapi.kakao.com',
      '/v3/search/book',
      {
        'target': 'title',
        'query': query,
        'page': '$page',
      },
    );

    try {
      final response = await http.get(
        uri,
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final dataConvertedToJSON = json.decode(response.body);
        final List result = dataConvertedToJSON['documents'];

        if (result.isEmpty && page == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('검색 결과가 없습니다.')),
          );
        }

        setState(() {
          data.addAll(result); // 결과 리스트에 추가
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('API 요청 실패: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: '책 제목을 입력하세요',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onSubmitted: (_) {
            page = 1;
            data.clear();
            getJSONData();
          },
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              page = 1;
              data.clear();
              getJSONData(); // 검색 실행
            },
          )
        ],
      ),
      body: Center(
        child: data.isEmpty
            ? const Text(
          '데이터가 존재하지 않습니다.\n검색해주세요',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        )
            : ListView.builder(
          controller: _scrollController,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final book = data[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 썸네일 이미지
                    if (book['thumbnail'] != '')
                      Image.network(
                        book['thumbnail'],
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      )
                    else
                      const SizedBox(height: 100, width: 100),
                    const SizedBox(width: 10),
                    // 책 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            book['title'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('저자 : ${book['authors'].toString()}'),
                          Text('가격 : ${book['sale_price'].toString()}'),
                          Text('판매중 : ${book['status'].toString()}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
