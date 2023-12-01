import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepositiory _repositiory;

  @override
  FutureOr<void> build() {
    _repositiory = ref.read(authRepo);
  }

  Future<void> githubSignIn(BuildContext context) async {
    state = const AsyncValue.loading();
    AsyncValue.guard(
      () async => await _repositiory.githubSignIn(),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error!);
    } else {
      context.go("/home");
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
    () => SocialAuthViewModel());
