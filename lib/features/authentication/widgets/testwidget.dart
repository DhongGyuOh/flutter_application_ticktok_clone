import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/////Model
class UserInfo {
  final String name;
  final String email;
  final String link;
  UserInfo({required this.name, required this.email, required this.link});
}

/////View
class TestScreen extends ConsumerStatefulWidget {
  static String routeName = "testwidget";
  static String routeURL = "/testwidget";
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
              top: 20,
              right: 20,
              child: Icon(
                Icons.mode_edit_outline_outlined,
                size: 40,
              )),
          Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 70, bottom: 20),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: Colors.amber,
                  ),
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "name",
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "email",
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: 2.9,
                      child: Icon(
                        Icons.link,
                        size: 32,
                        color: Colors.blue.shade400,
                      ),
                    ),
                    const Text(
                      "link",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
