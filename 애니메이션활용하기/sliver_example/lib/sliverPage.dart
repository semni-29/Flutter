import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 슬리버 페이지 위젯
class SliverPage extends StatefulWidget {
  const SliverPage({super.key});

  @override
  State<StatefulWidget> createState() => _SliverPage();
}

class _SliverPage extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // 상단 고정 SliverAppBar
          SliverAppBar(
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Sliver Example'),
              background: Image.asset('repo/images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          ),

          // 고정된 헤더 (리스트 제목)
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
              minHeight: 50,
              maxHeight: 150,
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'list 숫자',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            pinned: true,
          ),

          // 리스트 항목 1~4
          SliverList(
            delegate: SliverChildListDelegate([
              customCard('1'),
              customCard('2'),
              customCard('3'),
              customCard('4'),
            ]),
          ),

          // 고정된 헤더 (그리드 제목)
          SliverPersistentHeader(
            delegate: _HeaderDelegate(
              minHeight: 50,
              maxHeight: 150,
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text(
                    '그리드 숫자',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            pinned: true,
          ),

          // 그리드 항목 1~4
          SliverGrid(
            delegate: SliverChildListDelegate([
              customCard('1'),
              customCard('2'),
              customCard('3'),
              customCard('4'),
            ]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 한 줄에 2개씩
            ),
          ),

          // 동적으로 생성되는 리스트 항목 0~9
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return customCard('list count : $index');
              },
              childCount: 3, // 총 3개의 항목
            ),
          ),
        ],
      ),
    );
  }

  /// 카드 위젯 생성 함수
  Widget customCard(String text) {
    return Card(
      child: SizedBox(
        height: 120,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}

/// 고정 헤더에 사용되는 델리게이트 클래스
/// 슬리버 헤더 델리게이트 클래스
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // 슬리버 헤더에 자식 위젯을 꽉 차게 배치
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => math.max(minHeight, maxHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    // 내용이 바뀌었을 때만 다시 빌드
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
