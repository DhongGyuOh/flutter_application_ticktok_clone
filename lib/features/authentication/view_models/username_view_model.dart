import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNameViewModel extends AsyncNotifier<String> {
  late String userName;
  @override
  FutureOr<String> build() {
    userName = "";
    return userName;
  }

  Future<void> setUserName(String name) async {
    state = const AsyncValue.loading();
    userName = name;
    state = AsyncValue.data(userName);
  }
}

final userNameProvider =
    AsyncNotifierProvider<UserNameViewModel, String>(() => UserNameViewModel());
