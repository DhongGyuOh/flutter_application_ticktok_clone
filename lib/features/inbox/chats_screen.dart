import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final List<int> _items = [];
  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length,
          duration: const Duration(milliseconds: 200));
      _items.add(_items.length);
    }
    setState(() {});
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        duration: const Duration(milliseconds: 300),
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: Container(color: Colors.red, child: _makeTile(index)),
          ),
        ),
      );
      _items.removeAt(index);
    }
  }

  void _onChatTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatDetailScreen(),
        ));
  }

  Widget _makeTile(int index) {
    return ListTile(
      onTap: _onChatTap,
      onLongPress: () => _deleteItem(index),
      key: UniqueKey(),
      leading: const CircleAvatar(
        foregroundImage: NetworkImage(
            "https://yt3.ggpht.com/kzTD5rtJatYaUVZ3XP9AyPhWWKgT_RqDf8GvYZ1kCzxLZQMoC9676shlZ-blnogblZ0_gz5j8w=s88-c-k-c0x00ffffff-no-rj"),
        radius: 30,
      ),
      title: Text("MoMo $index"),
      subtitle: const Text("Hello My Friend. I'm Guitar Player"),
      trailing: const Text(
        "14:16 PM",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Direct Messages",
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
                onPressed: _addItem,
                icon: const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 20,
                ))
          ],
        ),
      ),
      body: AnimatedList(
        key: _key,
        itemBuilder: (context, index, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: SizeTransition(
                  sizeFactor: animation, child: _makeTile(index)),
            ),
          );
        },
      ),
    );
  }
}
