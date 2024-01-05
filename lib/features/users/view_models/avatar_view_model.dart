import 'dart:async';
import 'dart:io';

import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/features/users/repos/user_repo.dart';
import 'package:flutter_application_ticktok_clone/features/users/view_models/users_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
    //Repo초기화하기
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    //uid를 파일명으로 정함
    state = await AsyncValue.guard(() async {
      await _repository.uploadAvatar(file, fileName);
      await ref.read(usersProvider.notifier).onAvatarUpload();
    });
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
