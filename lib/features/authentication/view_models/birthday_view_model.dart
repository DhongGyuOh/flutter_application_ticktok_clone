import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BirthdayViewModel extends AsyncNotifier<String> {
  late String birthday;
  @override
  FutureOr<String> build() {
    birthday = "";
    return birthday;
  }

  Future<void> setBirthday(String day) async {
    state = const AsyncValue.loading();
    birthday = day;
    state = AsyncValue.data(birthday);
  }
}

final birthdayProvider = AsyncNotifierProvider<BirthdayViewModel, String>(
  () => BirthdayViewModel(),
);
