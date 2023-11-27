import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/login_screen.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/sign_up_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/activity_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/chats_screen.dart';
import 'package:flutter_application_ticktok_clone/features/onboarding/interests_screen.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  //Provider로 Notifier를 expose 하기위해 GoRouter 사용
  return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        //redirect: state의 값에 따라 어느 route로 redirect시킬지 정할 수 있음
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != SignUpScreen.routeURL &&
              state.matchedLocation != LoginScreen.routeURL) {
            //state.matchedLocation: 현재 위치해 있는 쿼리파라미터 값
            return SignUpScreen.routeURL;
            //initialLocation에 따라 /home으로 이동하려하지만
            //redirect의 조건문에 의해 Login이 되었는지 검사하고,
            ////(Firebase의 currentUser 메소드로 isLoggedIn에 로그인 되었는지 알아오고 Provider로 전달받음)
            //로그인이 되어있지않았다면 SignUpScreen.routeURL로 이동
          }
        }
        return null;
      },
      routes: [
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
              final position =
                  Tween(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
        )
      ]);
});
