import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Model
class User {
  User({required this.name, required this.autoLogin});
  final String name;
  final bool autoLogin;
}

//ViewModel
class UserViewModel extends AsyncNotifier<User> {
  //비동기적으로 Notifier를 사용하기위해 AsyncNotifier을 상속
  @override
  FutureOr<User> build() async {
    final user = User(name: "name", autoLogin: false);
    return user;
    //FutureOr로 User 초기화
  }

  Future<User> getUser() async {
    final user =
        User(name: state.value!.name, autoLogin: state.value!.autoLogin);
    return user;
    //User get 메소드
  }

  Future<void> setUserName(value) async {
    state = const AsyncValue.loading();
    //state를 로딩상태로 만들어줌
    await Future.delayed(const Duration(seconds: 2));
    //Future.delayred로 강제로 2초간 딜레이를 줌(Loading되는 예시를 구현하기 위함)
    state =
        AsyncValue.data(User(name: value, autoLogin: state.value!.autoLogin));
    //state에 data를 넣어줌 (로딩완료) set 매소드
  }

  Future<void> setUserAutoLogin(value) async {
    state = AsyncValue.data(User(name: state.value!.name, autoLogin: value));
  }
}

final userProvider =
    AsyncNotifierProvider<UserViewModel, User>(() => UserViewModel());
//AsyncNotifierProvider 생성

//View
class UserViewPage extends ConsumerStatefulWidget {
  const UserViewPage({super.key});

  @override
  UserViewPageState createState() => UserViewPageState();
}

class UserViewPageState extends ConsumerState<UserViewPage> {
  final TextEditingController _editingController = TextEditingController();
  //텍스트 입력창에 입력된 Text를 이용하기 위해 컨트롤러 생성

  @override
  void initState() {
    _editingController.addListener(() {});
    //컨트롤러 초기화
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.amber.shade800,
            height: 300,
            width: 300,
            child: ref.watch(userProvider).when(
                  //AsyncNotifierProvider 사용으로 when 기능 작성
                  loading: () => const CircularProgressIndicator(),
                  //loading: state가 로딩 상태일 때 보여줄 위젯을 작성하여 return함

                  error: (error, stackTrace) => Text("$error"),
                  //error: state가 로딩 상태일 때 보여줄 위젯을 작성하여 return함

                  data: (data) => Column(
                    //data: state가 데이터를 받았을 때 보여줄 위젯을 작성하여 return함
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ref.watch(userProvider).value!.name,
                        style: const TextStyle(fontSize: 40),
                      ),
                      TextField(
                        controller: _editingController,
                        cursorWidth: 2,
                        style: const TextStyle(fontSize: 20),
                      ),
                      SwitchListTile.adaptive(
                        title: const Text("autoLogin"),
                        value: ref.watch(userProvider).value!.autoLogin,
                        onChanged: (value) => ref
                            .read(userProvider.notifier)
                            .setUserAutoLogin(value),
                      ),
                      CupertinoButton(
                          child: const Text("이름 변경"),
                          onPressed: () => ref
                              .read(userProvider.notifier)
                              .setUserName(_editingController.text))
                    ],
                  ),
                )),
      ),
    );
  }
}
