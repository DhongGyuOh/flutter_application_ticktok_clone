import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepositiory _repositiory;

  @override
  FutureOr<void> build() {
    _repositiory = ref.read(authRepo);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
    //SnackBar를 사용하기 위해 BuildContext가 필요함
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repositiory.signIn(email, password),
    );
    if (context.mounted) {
      if (state.hasError) {
        final snack = SnackBar(
          content:
              Text((state.error as FirebaseException).message ?? '알수없는 오류입니다.'),
        );
        //FirebaseException: Firebase에서 제공하는 메세지
        ScaffoldMessenger.of(context).showSnackBar(snack);
      } else {
        context.go("/home");
      }
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
