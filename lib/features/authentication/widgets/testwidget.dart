import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<int> list = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  //ListTile 생성
  void _onAddTap() {
    if (_key.currentState != null) {
      _key.currentState!
          .insertItem(list.length, duration: const Duration(milliseconds: 200));
      list.add(list.length);
    }
    setState(() {});
  }

  void _onDeleteTap(int index) {
    _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(
              opacity: animation,
              child: Container(color: Colors.red, child: _makeListTile(index)),
            )));
    list.removeAt(index);
  }

  Widget _makeListTile(int index) {
    return ListTile(
      key: UniqueKey(),
      onLongPress: () => _onDeleteTap(index),
      leading: const FaIcon(
        FontAwesomeIcons.robot,
        color: Colors.purple,
      ),
      title: Text(
        "$index번 Bot",
        style:
            const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text("Ready"),
      trailing: const FaIcon(
        FontAwesomeIcons.solidCircleCheck,
        color: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Bot List",
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
                onPressed: _onAddTap,
                icon: const FaIcon(FontAwesomeIcons.userPlus)),
          ],
        ),
      ),
      body: AnimatedList(
        key: _key,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                  scale: animation, child: _makeListTile(index)));
        },
      ),
    );
  }
}
