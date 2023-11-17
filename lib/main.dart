import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testMVVM.dart';
import 'package:flutter_application_ticktok_clone/features/videos/repos/video_playback_config_repo.dart';
import 'package:flutter_application_ticktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:flutter_application_ticktok_clone/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); //사용자의 설정과 상관없이 세로모드 고정시킴
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark); //사용자의 설정과 상관없이 다크모드로 만듦

  final preferences = await SharedPreferences.getInstance();
  final repository = VideoPlaybackConfigRepository(preferences);

  final preferences2 = await SharedPreferences.getInstance();
  final repository2 = UserRepository(preferences2);

  runApp(ProviderScope(
    overrides: [
      playbackConfigProvider
          .overrideWith(() => PlaybackConfigViewModel(repository)),
      userViewModelProvider.overrideWith(() => UserViewModel(repository2))
    ],
    child: const TickTokApp(),
  ));
}

class TickTokApp extends StatelessWidget {
  const TickTokApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'NEW App',
        themeMode: ThemeMode.system,
        theme: ThemeData(
            brightness: Brightness.light,
            textTheme: Typography.blackCupertino,
            splashColor: Colors.transparent,
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Color(0xFFE9435A)),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            primaryColor: const Color(0xFFE9435A)),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            textTheme: Typography.whiteCupertino,
            textSelectionTheme:
                const TextSelectionThemeData(cursorColor: Color(0xFFE9435A)),
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
            iconTheme: const IconThemeData(color: Colors.white),
            bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade800),
            primaryColor: const Color(0xFFE9435A)));

    //home: const MainNavigationScreen());
    //home: const SignUpScreen());
  }
}
