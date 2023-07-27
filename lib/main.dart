import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/sign_up_screen.dart';
import 'package:flutter_application_ticktok_clone/features/onboarding/interests_screen.dart';

void main() {
  runApp(const TickTokApp());
}

class TickTokApp extends StatelessWidget {
  const TickTokApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NEW App',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            primaryColor: const Color(0xFFE9435A)),
        home: const SignUpScreen());
  }
}
