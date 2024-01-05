import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_ticktok_clone/features/users/models/user_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //FirebaseFirestore.instance: Store 에 접근하는 instance를 생성
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //FirebaseStorage.instance: Storage 에 접근하는 instance를 생성

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
    //.collection("users"): 이는 "users"라는 이름의 Firestore 컬렉션에 대한 참조를 얻습니다.
    // Firestore에서 컬렉션은 문서(document)의 모음입니다.
    //"users" 컬렉션에는 각 사용자의 정보가 저장될 것입니다.

    //.doc(profile.uid): 이 부분은 특정 사용자의 UID를 사용하여 해당 사용자의 문서에 대한 참조를 얻습니다.
    //각 사용자의 UID는 고유하게 식별되는 사용자를 나타내는 Firebase Authentication에서 제공되는 고유 식별자입니다.

    //.set(data): 마지막으로, set 메서드를 사용하여 문서에 데이터를 저장합니다.
    //data는 저장할 사용자 프로필 데이터를 나타냅니다. Json으로 보내야하기때문에 Map<>을 이용합니다.
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
    //firestore의 컬랙션 users의 document 중 해당하는 uid가 이미 있다면
    //그 document를 가져와 리턴함
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
    //.update: 컬랙션의 document를 update 시킴
    //현재 로그인된(uid) 사용자의 data를 update 시킴
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    //Firebase Storage에 접근하고 이 폴더 link를 가리키는 Reference 를 가져옴
    await fileRef.putFile(file);
    //Reference에 file을 넣음
  }
}

final userRepo = Provider((ref) => UserRepository());
