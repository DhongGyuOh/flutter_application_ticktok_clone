import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/features/videos/models/video_model.dart';
import 'package:flutter_application_ticktok_clone/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../users/view_models/users_view_model.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideoFile(video, user!.uid);
      if (task.metadata != null) {
        //task.metadata로 비디오 업로드 상태를 조건으로 걸어줌
        await _repository.saveVideo(VideoModel(
          id: "id",
          title: "title",
          description: "description",
          fileUrl: await task.ref.getDownloadURL(),
          thumbnailUrl: "thumbnailUrl",
          creatorUid: user.uid,
          creator: userProfile!.name,
          likes: 0,
          comments: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ));
        //storage에 비디오 저장
        if (context.mounted) {
          context.pushReplacement("/home");
        }
      }
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
    () => UploadVideoViewModel());
