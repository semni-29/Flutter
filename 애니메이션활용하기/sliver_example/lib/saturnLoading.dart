import 'package:flutter/material.dart';
import 'dart:math';

// SaturnLoading 위젯 정의
class SaturnLoading extends StatefulWidget {
  // _SaturnLoading의 인스턴스를 생성
  final _SaturnLoading _saturnLoading = _SaturnLoading();

  SaturnLoading({super.key});

  // 애니메이션 시작 메소드
  void start() {
    _saturnLoading.start();
  }

  // 애니메이션 중지 메소드
  void stop() {
    _saturnLoading.stop();
  }

  @override
  State<StatefulWidget> createState() => _saturnLoading;
}

// SaturnLoading 애니메이션 상태를 관리하는 클래스
class _SaturnLoading extends State<SaturnLoading> with SingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러와 애니메이션 객체 선언
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 초기화 (3초 동안 회전)
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    // 회전 애니메이션 설정 (0부터 2*pi까지 회전)
    _animation = Tween<double>(begin: 0, end: pi * 2).animate(_animationController!);
    // 애니메이션 시작
    _animationController!.repeat();
  }

  @override
  void dispose() {
    // 애니메이션 컨트롤러를 해제하여 리소스를 반환
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!, // 애니메이션을 빌드에 연결
      builder: (context, child) {
        return SizedBox(
          width: 100, // 애니메이션 위젯의 크기 설정
          height: 100,
          child: Stack(
            children: <Widget>[
              // 배경 원 이미지
              Image.asset(
                'repo/images/circle.png',
                width: 100,
                height: 100,
              ),
              // 중심에 있는 태양 이미지
              Center(
                child: Image.asset(
                  'repo/images/sunny.png',
                  width: 30,
                  height: 30,
                ),
              ),
              // 회전하는 토성 이미지
              Padding(
                padding: const EdgeInsets.all(5),
                child: Transform.rotate(
                  angle: _animation!.value, // 회전 각도
                  origin: const Offset(35, 35), // 회전 중심
                  child: Image.asset(
                    'repo/images/saturn.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // 애니메이션 중지 메소드
  void stop() {
    _animationController!.stop(canceled: true);
  }

  // 애니메이션 시작 메소드
  void start() {
    _animationController!.repeat();
  }
}

