import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Model: State로 관리할 User 객체를 만들어줌
class User {
  final String name;
  final bool autoLogin;
  User({required this.name, required this.autoLogin});
}

//ViewModel: 사용할 Model을 초기화하고 함께 사용할 메서드를 정의함, + Riverpod Provider 종류를 결정함
//AsyncNotifierProvider를 사용한다면 AsyncNotifier, NotifierProvider를 사용한다면 Notifier 를 extends 로 상속하면됨
class UserViewModel extends Notifier<User> {
  User user = User(name: "name", autoLogin: false);
  @override
  User build() {
    return User(name: "name", autoLogin: false);
    //build를 통한 초기화 부분(null방지)
  }

  User getUser() {
    return User(name: state.name, autoLogin: state.autoLogin);
    //state를 통해 user정보 가져오기
  }

  void setUserName(value) {
    user = User(name: value, autoLogin: state.autoLogin);
    state = user;
    //name Set 하고 state 최신화
  }

  void setUserAuthLogin(value) {
    user = User(name: state.name, autoLogin: value);
    state = user;
    //name Set 하고 state 최신화
  }
}

final userProvider = NotifierProvider<UserViewModel, User>(
  () => UserViewModel(),
);

//View: 위에서 생성한 ViewModel의 Provider을 실제 이용하는 화면
//ref로 provider를 사용하기 위해 ConsumerStatefulWidget 혹은 ConsumerWidget를 이용함
//이해를 돕기위해 두가지 모두 사용한 예시,
//ConsumerStatefulWidget으로 전체 틀을 만들고, ConsumerWidget으로 autoLogin 체크박스를 만들어봄
class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});
  //위젯트리에서 ref를 사용하기 위해 StatefulWidget 대신 ConsumerStatefulWidget 사용

  @override
  UserPageState createState() => UserPageState();
  //UserPageState로 createState 변경
}

class UserPageState extends ConsumerState<UserPage> {
  //ConsumerState는 ConsumerStatefulWidget과 한 세트임

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ref.watch(userProvider).name,
                style: const TextStyle(fontSize: 40),
              ),
              const StateSwitch(),
              Expanded(
                  child: TextField(
                maxLength: 10,
                style: const TextStyle(fontSize: 25),
                controller: _textEditingController,
              )),
              TextButton(
                  onPressed: () => ref
                      .read(userProvider.notifier)
                      .setUserName(_textEditingController.value.text),
                  child: const Text(
                    '이름바꾸기',
                    style: TextStyle(fontSize: 30),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class StateSwitch extends ConsumerWidget {
  const StateSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile.adaptive(
        title: const Text("AutoLogin"),
        value: ref.watch(userProvider).autoLogin,
        //watch로 리빌드함
        onChanged: (value) =>
            ref.read(userProvider.notifier).setUserAuthLogin(value));
    //메서드 사용은 provider에 .notifier를 붙여줘야함(read는 리빌드하지 않음)
  }
}
