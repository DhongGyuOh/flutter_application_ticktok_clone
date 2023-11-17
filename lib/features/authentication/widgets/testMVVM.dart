import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Model
class User {
  final bool receiveEmail;
  final bool receivePush;
  User({required this.receiveEmail, required this.receivePush});
}

//Repository
class UserRepository {
  final SharedPreferences _preferences;
  UserRepository(this._preferences);
  //기기에 데이터 저장하기 위해 SharedPreferences 패키지 사용
  //Repository를 생성할 때, SharedPreferences 를 인자로 받도록함(생성자)

  User? getUser() {
    final receiveEmail = _preferences.getBool('receiveEmail');
    final receivePush = _preferences.getBool('receivePush');
    //SharedPreferences.getString()으로 기기에 저장된 key의 value를 가져옴
    if (receiveEmail == null || receivePush == null) {
      return User(receiveEmail: false, receivePush: false);
    }
    return User(receiveEmail: receiveEmail, receivePush: receivePush);
    //값이 없으면 return null, 있으면 User에 값을 채워 return함
  }

  Future<void> setReceiveEmail(bool value) async {
    await _preferences.setBool('receiveEmail', value);
    //SharedPreferences.setString()으로 key 값을 기기에 저장함
  }

  Future<void> setReceivePush(bool value) async {
    await _preferences.setBool('receivePush', value);
    //SharedPreferences.setString()으로 key 값을 기기에 저장함
  }
}

//ViewModel
class UserViewModel extends Notifier<User> {
  final UserRepository _repository;
  UserViewModel(this._repository);

  void setReceiveEmail(bool value) {
    _repository.setReceiveEmail(value);
    state = User(receiveEmail: value, receivePush: state.receiveEmail);
  }

  void setReceivePush(bool value) {
    _repository.setReceivePush(value);
    state = User(receiveEmail: state.receivePush, receivePush: value);
  }

  @override
  User build() {
    User? user = _repository.getUser();
    return User(
        receiveEmail: user!.receiveEmail, receivePush: user.receivePush);
  }
}

final userViewModelProvider =
    NotifierProvider<UserViewModel, User>(() => throw UnimplementedError());

//view
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SwitchListTile.adaptive(
            title: const Text('receiveEmail'),
            value: ref.watch(userViewModelProvider).receiveEmail,
            onChanged: (value) {
              ref.read(userViewModelProvider.notifier).setReceiveEmail(value);
            },
          ),
          SwitchListTile.adaptive(
            title: const Text('receivePush'),
            value: ref.watch(userViewModelProvider).receivePush,
            onChanged: (value) {
              ref.read(userViewModelProvider.notifier).setReceivePush(value);
            },
          ),
        ],
      ),
    );
  }
}
