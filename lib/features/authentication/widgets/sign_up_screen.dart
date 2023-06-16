import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/username_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  void onEmailTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UsernameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
        child: Column(
          children: [
            Gaps.v80,
            const Text(
              'Sign Up For NEW',
              style: TextStyle(
                  fontSize: Sizes.size28, fontWeight: FontWeight.w500),
            ),
            Gaps.v20,
            const Text(
              'Create a profile, follow other accounts, make your own videos',
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black45),
              textAlign: TextAlign.center,
            ),
            Gaps.v32,
            GestureDetector(
              onTap: () => onEmailTap(context),
              child: const AuthButton(
                  text: 'User Email & Password',
                  icon: FaIcon(FontAwesomeIcons.user)),
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
                onTap: () => onLoginTap(context),
                child: Text(
                  'Log In',
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
