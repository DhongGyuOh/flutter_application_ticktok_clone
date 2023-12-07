import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile_model.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) throw Exception("Account not created");
    state = AsyncValue.data(UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: credential.user!.displayName ?? "Anon",
      bio: "AnonBio",
      link: "AnonLink",
    ));
  }
}

final usersProvider = AsyncNotifierProvider(() => UserViewModel());
