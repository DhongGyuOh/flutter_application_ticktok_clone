import 'package:flutter_application_ticktok_clone/features/authentication/widgets/email_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/login_form_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/login_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/password_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/sign_up_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget.dart';
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
      path: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) => const EmailScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: UsernameScreen.routeName,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: TestScreen.routeName,
      builder: (context, state) => const TestScreen(),
    ),
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
      path: TestScreen.routeName,
      builder: (context, state) => const TestScreen(),
    ),
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
    )
  ],
);
