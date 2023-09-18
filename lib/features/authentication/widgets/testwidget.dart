import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  final List<String> addressList = [
    "010-1234-1234",
    "010-0000-0000",
    "010-1111-1111",
    "010-2222-2222",
    "010-3333-3333",
    "010-4444-4444",
    "010-5555-5555",
    "010-6666-6666",
    "010-7777-7777",
    "010-8888-8888",
    "010-9999-9999",
  ];

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<double> _animationRotation =
      Tween(begin: 0.0, end: -0.25).animate(_animationController);
  late final Animation<Offset> _animationSlider =
      Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
          .animate(_animationController);
  void _onTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AnimationController, Animation",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: _onTap,
              titleAlignment: ListTileTitleAlignment.center,
              contentPadding: const EdgeInsets.all(10),
              title: const Text("Address"),
              leading: RotationTransition(
                  turns: _animationRotation,
                  child: const FaIcon(FontAwesomeIcons.addressBook)),
              minLeadingWidth: 10,
            ),
            SlideTransition(
              position: _animationSlider,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var address in addressList)
                    ListTile(
                      title: Text(address),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
