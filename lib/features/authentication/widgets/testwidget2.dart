import 'package:flutter/material.dart';

class TestScreen2 extends StatelessWidget {
  static String routeName = 'test2';
  static String routeURL = 'test2';

  final String value;
  final String type;
  const TestScreen2({super.key, required this.value, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("전달받은 값"),
            Text(
              value,
              style: const TextStyle(fontSize: 32),
            ),
            Text(type)
          ],
        ),
      ),
    );
  }
}
