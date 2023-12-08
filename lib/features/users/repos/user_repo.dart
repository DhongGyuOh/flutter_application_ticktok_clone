import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_ticktok_clone/features/users/models/user_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //FirebaseFirestore.instance: FireStore 에 접근하는 instance를 생성

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
}

final userRepo = Provider((ref) => UserRepository());
