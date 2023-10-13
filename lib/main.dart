import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); //사용자의 설정과 상관없이 세로모드 고정시킴
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark); //사용자의 설정과 상관없이 다크모드로 만듦
  runApp(const TickTokApp());
}

class TickTokApp extends StatelessWidget {
  const TickTokApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NEW App',
        theme: ThemeData(
            splashColor: Colors.transparent,
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Color(0xFFE9435A)),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            primaryColor: const Color(0xFFE9435A)),
        //home: const MainNavigationScreen());
        home: const LayoutBuilderCodeLab());
  }
}

class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          color: Colors.teal,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Center(
            child: Text(
              "${constraints.maxWidth} /// ${size.width}",
              style: TextStyle(fontSize: constraints.maxWidth > 700 ? 70 : 30),
            ),
          ),
        ),
      ),
    );
  }
}
