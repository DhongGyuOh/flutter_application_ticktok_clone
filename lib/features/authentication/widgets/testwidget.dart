import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late List<String> movies = [
    "바람과 함께 사라지다",
    "아이리시맨",
    "반지의 제왕 : 왕의 귀환",
    "트로이 디렉터스 컷",
    "타이타닉",
    "아바타: 물의 길",
    "작가 미상",
    "바빌론",
    "베티블루 37.2 디오리지널",
    "어벤져스: 엔드게임",
    "내부자들: 디 오리지널",
    "오펜하이머",
    "가장 따뜻한 색, 블루",
    "드라이브 마이 카",
    "반지의 제왕 : 두개의 탑",
    "반지의 제왕 : 반지원정대",
    "보 이즈 어프레이드",
    "팬텀: 더 뮤지컬 라이브",
    "더 배트맨"
  ];
  void _onDismissed(DismissDirection direction, int index) {
    print("방향: $direction, dismiss된 데이터: ${movies[index]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direction) => _onDismissed(direction, index),
            background: Container(
                color: Colors.green.shade400,
                alignment: Alignment.centerLeft,
                child: const FaIcon(FontAwesomeIcons.moneyCheckDollar)),
            secondaryBackground: Container(
                color: Colors.red.shade400,
                alignment: Alignment.centerRight,
                child: const FaIcon(FontAwesomeIcons.trashCan)),
            key: Key("$index"),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.amber.shade300),
                child: Center(
                  child: Text(
                    movies[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
