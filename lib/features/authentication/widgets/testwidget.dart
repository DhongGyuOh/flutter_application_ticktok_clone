import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late bool _showFirstWidget = true;
  late bool _dragleft = true;
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _dragleft = true;
      });
    } else {
      setState(() {
        _dragleft = false;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dragleft) {
      setState(() {
        _showFirstWidget = true;
      });
    } else {
      setState(() {
        _showFirstWidget = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: AnimatedCrossFade(
              firstChild: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AnimatedCrossFade\nFirst Screen\n\nDrag Right to Left ←',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    ' As the waves crashed against the shore, the salty sea breeze filled the air, creating a soothing atmosphere that instantly put my mind at ease.',
                    style: TextStyle(fontSize: 20, color: Colors.indigo),
                  )
                ],
              ),
              secondChild: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AnimatedCrossFade\nSecond Screen\n\nDrag Left to Right →',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    "Walking through the bustling streets of the city, I couldn't help but be captivated by the vibrant sights and sounds that surrounded me, immersing myself in the energy of urban life.",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )
                ],
              ),
              crossFadeState: _showFirstWidget
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300)),
        ),
      ),
    );
  }
}
