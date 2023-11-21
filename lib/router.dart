import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/login_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/sign_up_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/activity_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/chats_screen.dart';
import 'package:flutter_application_ticktok_clone/features/onboarding/interests_screen.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: "/home", routes: [
  GoRoute(
    path: SignUpScreen.routeURL,
    name: SignUpScreen.routeName,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: LoginScreen.routeURL,
    name: LoginScreen.routeName,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: InterestScreen.routeURL,
    name: InterestScreen.routeName,
    builder: (context, state) => const InterestScreen(),
  ),
  GoRoute(
      path: "/:tab(home|discover|inbox|profile)",
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.pathParameters['tab']!;
        return MainNavigationScreen(
          tab: tab,
        );
      },
      routes: const []),
  GoRoute(
    path: ActivityScreen.routeURL,
    name: ActivityScreen.routeName,
    builder: (context, state) => const ActivityScreen(),
  ),
  GoRoute(
      path: ChatsScreen.routeURL,
      name: ChatsScreen.routeName,
      builder: (context, state) => const ChatsScreen(),
      routes: [
        GoRoute(
          path: ChatDetailScreen.routeURL,
          name: ChatDetailScreen.routeName,
          builder: (context, state) {
            final chatId = state.pathParameters["chatId"]!;
            return ChatDetailScreen(chatId: chatId);
          },
        )
      ]),
  GoRoute(
    path: VideoRecordingScreen.routeURL,
    name: VideoRecordingScreen.routeName,
    pageBuilder: (context, state) => CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 200),
      child: const VideoRecordingScreen(),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        final position = Tween(begin: const Offset(0, 1), end: Offset.zero)
            .animate(animation);
        return SlideTransition(
          position: position,
          child: child,
        );
      },
    ),
  )
]);
