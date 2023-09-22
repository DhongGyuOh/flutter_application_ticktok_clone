import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
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
      body: Column(
        children: [
          const SizedBox(
            height: 70,
            child: Center(
              child: Text(
                "December16, 2022 3:29PM",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Gaps.v10,
          Stack(
            children: [
              ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: 8,
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
                              borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(15),
                                  bottomRight:
                                      Radius.circular(index % 2 == 1 ? 0 : 15),
                                  topLeft: const Radius.circular(15),
                                  topRight: const Radius.circular(15)),
                              color: index % 2 == 1
                                  ? Colors.blue.shade700
                                  : Colors.white),
                          child: const Text(
                            "🐟🤟🏻🐿️🐸😊💕",
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Gaps.v16)
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        child: TextField(),
      ),
    );
  }
}
