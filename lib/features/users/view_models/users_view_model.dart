import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/view_models/birthday_view_model.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/view_models/username_view_model.dart';
import 'package:flutter_application_ticktok_clone/features/users/repos/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepositiory _authenticationRepositiory;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepositiory = ref.read(authRepo);
    if (_authenticationRepositiory.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepositiory.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) throw Exception("Account not created");
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
        hasAvatar: false,
        uid: credential.user!.uid,
        email: credential.user!.email ?? "anon@anon.com",
        name:
            credential.user!.displayName ?? ref.watch(userNameProvider).value!,
        bio: "AnonBio",
        link: "AnonLink",
        birthday: ref.watch(birthdayProvider).value!);
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    //copyWith로 state의 hasAvatar 값을 true로 업데이트함
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
    //Update된 state 정보(hasAvatar)를 Json형태(Map)로 바꾸어주고
    //이를 updateUser 메소드에 전달하여 firestore의 Store에 업데이트함
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
