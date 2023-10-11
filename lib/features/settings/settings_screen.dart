import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListWheelScrollView(
            itemExtent: 200,
            //useMagnifier: true,
            //magnification: 1.5,
            diameterRatio: 2,
            children: [
              for (int i = 0; i < 10; i++)
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: const Text('pick'),
                  ),
                )
            ]));
  }
}
