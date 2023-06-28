import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';

class InterestScreen extends StatelessWidget {
  InterestScreen({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose Your Interests',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size14, horizontal: Sizes.size14),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Sizes.size32),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.09),
                                blurRadius: 5,
                                spreadRadius: 5)
                          ]),
                      child: Text(
                        interest,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: Sizes.size5,
              top: Sizes.size5,
              left: Sizes.size24,
              right: Sizes.size24),
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size10, vertical: Sizes.size20),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: Sizes.size20),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
