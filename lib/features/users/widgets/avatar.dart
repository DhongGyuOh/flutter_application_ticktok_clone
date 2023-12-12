import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/users/view_models/avatar_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends ConsumerWidget {
  const Avatar(
      {super.key,
      required this.name,
      required this.hasAvatar,
      required this.uid});
  final String name;
  final bool hasAvatar;
  final String uid;

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 150,
        maxWidth: 150);
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/tiktokclone-f68f0.appspot.com/o/avatars%2F$uid?alt=media&haha=${DateTime.now().toString()}"),
              //새로운 URL을 만들어 캐싱을 돌게해주기 위해 야매로 DateTime.now()가 들어있는 haha라는 토큰을 추가해줌
            ),
    );
  }
}
