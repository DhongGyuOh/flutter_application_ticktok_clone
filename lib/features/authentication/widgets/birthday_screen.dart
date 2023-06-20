import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size32, vertical: Sizes.size10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "When;s Your Birthday",
                  style: TextStyle(
                      fontSize: Sizes.size28, fontWeight: FontWeight.bold),
                ),
                Gaps.v20,
                Gaps.v20,
                FormButton(disabled: true)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
