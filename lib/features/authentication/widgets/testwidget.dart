import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  void _onTap(BuildContext context) async {
    await showModalBottomSheet(
      shape: Border.all(),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(color: Colors.white),
          clipBehavior: Clip.hardEdge,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: const Text(
                "showModalBottomSheet",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: 16,
              itemBuilder: (context, index) {
                return const Row(
                  children: [
                    CircleAvatar(
                      child: FaIcon(FontAwesomeIcons.guitar),
                    ),
                    Text("Guitar")
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => _onTap(context),
          child: const CircleAvatar(
            radius: 30,
            child: Text("Gyu"),
          ),
        ),
      ),
    );
  }
}
