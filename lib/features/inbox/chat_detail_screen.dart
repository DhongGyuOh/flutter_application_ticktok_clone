import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends StatefulWidget {
  static String routeName = "/chatdetail";
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final bool _isTapped = false;

  void _onTap() {
    setState(() {
      _isTapped != _isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                          radius: 23,
                          foregroundImage: NetworkImage(
                            "https://img1.daumcdn.net/thumb/C100x100/?scode=mtistory2&fname=https%3A%2F%2Ftistory3.daumcdn.net%2Ftistory%2F4506296%2Fattach%2F27003a1355e84452a5cc9d2dc88c59ca",
                          )),
                      Positioned(
                        right: -2,
                        bottom: -1,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.5, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  Gaps.h10,
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "mroh1226",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Gaps.v3,
                      Text(
                        "Active now",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              const Row(
                children: [
                  FaIcon(FontAwesomeIcons.flag),
                  Gaps.h10,
                  FaIcon(FontAwesomeIcons.barsStaggered)
                ],
              ),
            ],
          )),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Center(
                child: Text(
                  "December16, 2022 3:29PM",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Gaps.v10,
            MessagePop(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextField(
          onTap: _onTap,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
              labelText: "Send your messages.",
              suffixIcon:
                  FaIcon(FontAwesomeIcons.paperPlane, color: Colors.blue),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class MessagePop extends StatelessWidget {
  const MessagePop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ListView.separated(
          itemCount: 16,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: index % 2 == 1
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(index % 2 == 1 ? 15 : 0),
                          bottomRight: Radius.circular(index % 2 == 1 ? 0 : 15),
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15)),
                      color:
                          index % 2 == 1 ? Colors.blue.shade700 : Colors.white),
                  child: Text(
                    "Test Message💻",
                    style: TextStyle(
                        color: index % 2 == 1 ? Colors.white : Colors.black,
                        fontSize: 18),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => Gaps.v16),
    );
  }
}
