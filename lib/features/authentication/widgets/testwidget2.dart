import 'package:flutter/material.dart';

class TestScreen2 extends StatefulWidget {
  static String routeName = "testwidget2";
  static String routeURL = "testwidget2";

  const TestScreen2({super.key});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video PreView'),
        ),
        body: const Center());
  }
}
