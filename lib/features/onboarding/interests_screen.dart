import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/interests_button.dart';
import 'package:flutter_application_ticktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:go_router/go_router.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});
  static String routeName = "/interest";
  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final interests = [
    "Daily Life",
    "Comedy",
    "Entertainment",
    "Animals",
    "Food",
    "Beauty & Style",
    "Drama",
    "Learning",
    "Talent",
    "Sports",
    "Auto",
    "Family",
    "Fitness & Health",
    "DIY & Life Hacks",
    "Arts & Crafts",
    "Dance",
    "Outdoors",
    "Oddly Satisfying",
    "Home & Garden",
    "Daily Life",
    "Comedy",
    "Entertainment",
    "Animals",
    "Food",
    "Beauty & Style",
    "Drama",
    "Learning",
    "Talent",
    "Sports",
    "Auto",
    "Family",
    "Fitness & Health",
    "DIY & Life Hacks",
    "Arts & Crafts",
    "Dance",
    "Outdoors",
    "Oddly Satisfying",
    "Home & Garden",
  ];

  final ScrollController _scrollController = ScrollController();

  late bool _appbarVisible = false;

  void _onScroll() {
    if (_scrollController.offset > 10) {
      setState(() {
        _appbarVisible = true;
      });
    } else {
      setState(() {
        _appbarVisible = false;
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      _onScroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onTap(BuildContext context) {
    context.push(TutorialScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _appbarVisible ? 1 : 0,
          child: const Text(
            'Choose Your Interests',
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const Text(
                  'Choose Your Interests',
                  style: TextStyle(
                      fontSize: Sizes.size40, fontWeight: FontWeight.w600),
                ),
                Gaps.v12,
                const Text(
                  'Get Better Video Recommendations',
                  style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                Gaps.v32,
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var interest in interests)
                      InterestsButton(interest: interest)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          child: const Text(
            'Next',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          onPressed: () => _onTap(context),
        ),
      ),
    );
  }
}
