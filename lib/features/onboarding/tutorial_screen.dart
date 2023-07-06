import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const SafeArea(
            child: TabBarView(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                Text(
                  'Watch Cool Videos!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Sizes.size32, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                Text(
                  'Follow The Rules Of The App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Sizes.size32, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                Text(
                  'Enjoy The Ride.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Sizes.size32, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ])),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabPageSelector(
                  color: Colors.white,
                  selectedColor: Theme.of(context).primaryColor,
                  borderStyle: BorderStyle.solid,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
