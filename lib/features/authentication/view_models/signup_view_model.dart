import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/features/onboarding/interests_screen.dart';
import 'package:flutter_application_ticktok_clone/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../users/view_models/users_view_model.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepositiory _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );
      await users.createAccount(userCredential);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error!);
    } else {
      context.goNamed(InterestScreen.routeName);
    }
  }

  // Future<void> signUp(
  //   BuildContext context,
  // ) async {
  //   state = const AsyncValue.loading();
  //   //처리 중인 것을 알리기위해 state를 AsyncValue.loading() 상태로 변경
  //   final form = ref.read(signUpForm);
  //   ////data 처리완료 알리기 방법.1 AsyncValue.guard 사용
  //   state = await AsyncValue.guard(() async => await _authRepo.signUp(
  //         form["email"],
  //         form["password"],
  //         //guard: 에러발생과 데이터 처리결과 상태를 상황에 맞게 state에 넣어줌
  //       ));
  //   if (state.hasError) {
  //     showFirebaseErrorSnack(context, state.error!);
  //   } else {
  //     context.goNamed(InterestScreen.routeName);
  //   }

  //   ////data 처리완료 알리기 방법.2 AsyncValue.data(null) 사용
  //   // await _authRepo.signUp(form["email"], form["password"]);
  //   // state = const AsyncValue.data(null);
  //   // //data 처리가 끝났다면 state에 AsyncValue.data(null)로 상태 변경
  //   // //expose하는 것이 없기 때문에 null을 넣음
  // }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
