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
        appBar: AppBar(
          title: const Text('appBar'),
        ),
        body: Center(
          child: Column(
            children: [
              for (int i = 0; i < 5; i++)
                const ListTile(
                  title: Text('안녕'),
                  subtitle: Text('안녕하세요.'),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.amber,
                  ),
                )
            ],
          ),
        ));
  }
}
