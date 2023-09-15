import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));

  late final Animation<double> _animation =
      Tween(begin: 0.0, end: -0.25).animate(_animationController);
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
      body: Column(
        children: [
          ListTile(
            onTap: _onTap,
            titleAlignment: ListTileTitleAlignment.center,
            contentPadding: const EdgeInsets.all(10),
            title: const Text("Address"),
            leading: RotationTransition(
                turns: _animation,
                child: const FaIcon(FontAwesomeIcons.addressBook)),
            minLeadingWidth: 10,
          ),
        ],
      ),
    );
  }
}
