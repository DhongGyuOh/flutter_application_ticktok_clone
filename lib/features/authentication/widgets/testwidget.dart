import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWheelScrollView(
          perspective: 0.005,
          useMagnifier: true,
          magnification: 2,
          offAxisFraction: 0.9,
          itemExtent: 100,
          children: [
            for (int i = 0; i < 10; i++)
              Container(
                color: Colors.indigo.shade400,
                alignment: Alignment.center,
                child: Text('$i'),
              )
          ]),
    );
  }
}
