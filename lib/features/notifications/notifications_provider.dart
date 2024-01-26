import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/features/inbox/views/chats_screen.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    await _db.collection("users").doc(user!.uid).update({"token": token});
  }

  Future<void> initListeners(BuildContext context) async {
    //push 알림 권한 얻기
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) return;

    //1. 어플이 열려있을 때 Push 알림(Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("foreground message");
      print(event.notification?.title);
    });

    //2. 어플이 닫혀있을 때 Push 알림(Background)
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //Push 알림에 data를 추가로 보내고 이를 받아올 수 있음
      //print(event.data["screen"]);
      context.pushNamed(ChatsScreen.routeName);
    });

    //3. 앱이 종료된 상태에서의 Push 알림 (Terminated)
    final notification = await _messaging.getInitialMessage();
    if (notification == null) return;
    //print(notification.data["screen"]);
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  FutureOr build(BuildContext context) async {
    final token = await _messaging.getToken(); //알림을 보내기 위한 Token을 가져옴
    print("토큰: $token");
    if (token == null) return;
    await updateToken(token);
    await initListeners(context);
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
