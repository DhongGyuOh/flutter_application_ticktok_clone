import 'package:flutter_application_ticktok_clone/features/authentication/widgets/email_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/login_form_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/login_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/password_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/sign_up_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget2.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/username_screen.dart';
import 'package:flutter_application_ticktok_clone/features/discover/discover_screen.dart';
import 'package:flutter_application_ticktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:flutter_application_ticktok_clone/features/onboarding/interests_screen.dart';
import 'package:flutter_application_ticktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:flutter_application_ticktok_clone/features/videos/video_timeline_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
        routes: [
          GoRoute(
              name: UsernameScreen.routeName,
              path: UsernameScreen.routeURL,
              builder: (context, state) => const UsernameScreen(),
              routes: [
                GoRoute(
                    name: EmailScreen.routeName,
                    path: EmailScreen.routeURL,
                    builder: (context, state) {
                      final username = state.extra as String;
                      return EmailScreen(username: username);
                    }),
              ]),
        ]),
    GoRoute(
      path: InterestScreen.routeName,
      builder: (context, state) => const InterestScreen(),
    ),
    GoRoute(
      path: VideoTimelineScreen.routeName,
      builder: (context, state) => const VideoTimelineScreen(),
    ),
    GoRoute(
      path: LoginFormScreen.routeName,
      builder: (context, state) => const LoginFormScreen(),
    ),
    GoRoute(
      path: PasswordScreen.routeName,
      builder: (context, state) => const PasswordScreen(),
    ),
    GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
              name: "test",
              path: "test",
              builder: (context, state) => const TestScreen(),
              routes: [
                GoRoute(
                  name: "test2",
                  path: "test2/:value",
                  builder: (context, state) {
                    final String value = state.pathParameters['value']!;
                    final String type = state.uri.queryParameters['type']!;

                    return TestScreen2(value: value, type: type);
                  },
                )
              ]),
        ]),
    GoRoute(
      path: DiscoverScreen.routeName,
      builder: (context, state) => const DiscoverScreen(),
    ),
    GoRoute(
      path: MainNavigationScreen.routeName,
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: TutorialScreen.routeName,
      builder: (context, state) => const TutorialScreen(),
    ),
  ],
);
