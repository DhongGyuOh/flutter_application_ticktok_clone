import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LoginScreen> {
  void onSignUpTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
        child: Column(
          children: [
            Gaps.v80,
            Text(
              'Log In To NEW',
              style: TextStyle(
                  fontSize: Sizes.size28, fontWeight: FontWeight.w500),
            ),
            Gaps.v20,
            Text(
              'Manage Your Account, Check Notifications, Comment On Videos, And More.',
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black45),
              textAlign: TextAlign.center,
            ),
            Gaps.v32,
            AuthButton(
              text: 'Use Phone Or Email',
              icon: FaIcon(
                FontAwesomeIcons.phone,
                color: Colors.amber,
              ),
            ),
            Gaps.v10,
            AuthButton(
              text: 'Continue With Facebook',
              icon: FaIcon(
                FontAwesomeIcons.facebook,
                size: 30,
                color: Colors.blue,
              ),
            ),
            Gaps.v10,
            AuthButton(
              text: 'Continue With Apple',
              icon: FaIcon(
                FontAwesomeIcons.apple,
                size: 30,
              ),
            ),
            Gaps.v10,
            AuthButton(
              text: 'Continue With Google',
              icon: FaIcon(
                FontAwesomeIcons.google,
                size: 30,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already Have An Account?',
                style: TextStyle(),
              ),
              Gaps.h9,
              GestureDetector(
                onTap: () => onSignUpTap(),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
