import 'package:flutter/material.dart';

import 'features/main_navigation/main_navigation_screen.dart';

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
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Color(0xFFE9435A)),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            primaryColor: const Color(0xFFE9435A)),
        home: const MainNavigationScreen());
    //home: const SignUpScreen());
  }
}
