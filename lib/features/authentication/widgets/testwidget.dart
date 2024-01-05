import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

//Repository//////////////////
class StorageRepository {
  //Storage를 사용하시위해 FirebaseStorage instance를 선언
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //Avatar로 사용될 File과 파일명을 파라미터로 받아 upload하는 메소드
  Future<void> uploadAvatarImage(File file, String fileName) async {
    //Firebase Storage에 접근하고 이 폴더 link를 가리키는 Reference를 가져옴
    final fileRef = _firebaseStorage.ref().child("avatar_image/$fileName");
    //Reference에 file을 넣음
    await fileRef.putFile(file);
  }
}

final storageRepoProvider = Provider((ref) => StorageRepository());

//ViewModel////////////////////////////////
class AvatarImageViewModel extends AsyncNotifier<void> {
  late final StorageRepository _storageRepository;
  @override
  FutureOr<void> build() {
    //Storage Repository를 Provider로 초기화
    _storageRepository = ref.read(storageRepoProvider);
  }

  //AvatarImage 업로드 메소드 파일명은 날짜
  Future<void> uploadAvatarImage(File file) async {
    //upload하는 동안 state를 loading 상태로 변경
    state = const AsyncValue.loading();
    //파일명을 날짜로 받음
    final filename = DateTime.now().toString();
    //data 예외처리를 위해 guard를 사용
    state = await AsyncValue.guard(() async {
      //StorageRepository의 uploadAvatarImage 메소드에 file과 filename을 주고 호출
      await _storageRepository.uploadAvatarImage(file, filename);
    });
  }
}

final avatarImageProvider = AsyncNotifierProvider<AvatarImageViewModel, void>(
  () => AvatarImageViewModel(),
);

//View/////////////////////////////////////
class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  //CircleAvatar 클릭했을 때 메소드
  Future<void> tapAvatar() async {
    //ImagePicker로 받아온 file을 받아옴
    final xfile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 40,
        maxHeight: 150,
        maxWidth: 150);
    if (xfile != null) {
      final file = File(xfile.path);
      //avatarImageProvider로 ViewModel에 있는 uploadAvatarImage에 file을 넘겨주고 호출
      ref.read(avatarImageProvider.notifier).uploadAvatarImage(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => tapAvatar(),
          child: CircleAvatar(
            backgroundColor: Colors.red.shade300,
            radius: 100,
          ),
        ),
      ),
    );
  }
}
