import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_ticktok_clone/features/users/models/user_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //FirebaseFirestore.instance: FireStore 에 접근하는 instance를 생성

  Future<void> createProfile(UserProfileModel user) async {}
}

final userRepo = Provider((ref) => UserRepository());
