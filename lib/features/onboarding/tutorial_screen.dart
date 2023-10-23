import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:go_router/go_router.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  static String routeName = "/tutorial";
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction direction = Direction.right;
  Page page = Page.first;
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      //dx는 x축

      setState(() {
        direction = Direction.right;
      });
    } else {
      setState(() {
        direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (direction == Direction.left) {
      setState(() {
        page = Page.second;
      });
    } else {
      setState(() {
        page = Page.first;
      });
    }
  }

  void _onTap(BuildContext context) {
    context.go(MainNavigationScreen.routeName);
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //       builder: (context) => const MainNavigationScreen(),
    //     ),
    //     (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate, //화면을 드레그 했을 때
      onPanEnd: _onPanEnd, //화면 드레그가 끝났을 때
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24, horizontal: Sizes.size14),
          child: SafeArea(
            child: AnimatedCrossFade(
                firstChild: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Watch Cool Videos!',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: Sizes.size32, fontWeight: FontWeight.bold),
                    ),
                    Gaps.v16,
                    Text(
                      'videos are personalized for you based on what you watch, like, and share.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
                secondChild: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow The Rules Of The App',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: Sizes.size32, fontWeight: FontWeight.bold),
                    ),
                    Gaps.v16,
                    Text(
                      'Take care of one another! Plis!',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
                crossFadeState: page == Page.first
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300)),
          ),
        ),
        bottomNavigationBar: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: page == Page.first ? 0 : 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: BottomAppBar(
              child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: const Text(
                  'Enter the app !',
                ),
                onPressed: () => _onTap(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialTabBarView extends StatelessWidget {
  const TutorialTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
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
        bottomNavigationBar: TutorialTabPageSelector(),
      ),
    );
  }
}

class TutorialTabPageSelector extends StatelessWidget {
  const TutorialTabPageSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}
