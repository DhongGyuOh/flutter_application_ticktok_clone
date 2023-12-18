import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

////Firebase Authenication Repository/////////////////////////////////////////
class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //Firebase의 Authentication을 다룰 수 있도록 FirebaseAuth 인스턴스를 생성함
  User? get user => _firebaseAuth.currentUser; //get 정의하는 방법 중 하나
  bool get isLoggedIn => user != null;
  //_firebaseAuth.currentUser: Firebase에 currentUser가 있는지? 유무로 로그인 되었는지 확인함
  // bool isLoggedIn() {
  //   return (_firebaseAuth.currentUser != null);
  // }
  Stream<User?> authStateChange() => _firebaseAuth.authStateChanges();

  Future<UserCredential> createUser(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    //.createUserWithEmailAndPassword(): 유저 이메일/비밀번호로 로그인 인증을 생성함
  }

  Future<void> userSignOut() async {
    await _firebaseAuth.signOut();
    //.signOut() 로그아웃하는 메서드
  }

  Future<void> userSignIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    //.signInWithEmailAndPassword: firebase 이메일,비밀번호로 로그인
  }
}

final authRepoProvider = Provider((ref) => AuthRepository());
//AuthRepository() 를 expose 하기 위해 만들어진 Provider
final authStreamProvider =
    StreamProvider((ref) => ref.read(authRepoProvider).authStateChange());
//AuthRepository()의 _firebaseAuth.authStateChanges() 로
//sign-in 이나 sign-out의 실시간 변화를 expose하기 위해 만들어진 Provider

////ViewModel/////////////////////////////////////////////////////////////////////////
class LoginViewModel extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  FutureOr<void> build() async {
    _authRepository = ref.read(authRepoProvider);
    //authRepoProvider로 AuthRepository()가 가진 것들을 _authRepository에 넣음
  }

  Future<void> logIn(
      String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    //로딩 상태로 들어감
    state = await AsyncValue.guard(
        //guard: 에러발생과 데이터 처리결과 상태를 상황에 맞게 state에 넣어줌
        () async => await _authRepository.userSignIn(email, password));
    if (state.hasError) {
      final snackBar = SnackBar(
          content: Text(
              (state.error as FirebaseException).message ?? "알수없는 오류입니다."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      return;
    }
  }

  Future<void> logOut() async {
    await ref.read(authRepoProvider).userSignOut();
  }

  Future<void> createUsers(String email, String password) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final userCredential =
          await ref.read(authRepoProvider).createUser(email, password);
      await ref.read(userInfoProvider.notifier).createAccount(userCredential);
    });
  }

  String getEmail() {
    String email = _authRepository.user?.email ?? "로그인 해주세요.";
    return email;
  }
}

final userStateProvider = StateProvider((ref) => {});
final userProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);

////View////////////////////////////////////////////////////////////////////
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  Future<void> _onTapLogin() async {
    if (_emailTextEditingController.text.isEmpty ||
        _passwordTextEditingController.text.isEmpty) return;

    ref.read(userProvider.notifier).logIn(_emailTextEditingController.text,
        _passwordTextEditingController.text, context);
    setState(() {});
  }

  void _onTapLogout() {
    ref.read(userProvider.notifier).logOut();
    setState(() {});
  }

  void _onTapCreateUser() {
    ref.read(userProvider.notifier).createUsers(
        _emailTextEditingController.text, _passwordTextEditingController.text);
    setState(() {});
  }

  @override
  void initState() {
    _emailTextEditingController.addListener(() {});
    _passwordTextEditingController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ref.watch(authRepoProvider).isLoggedIn
              ? Icon(
                  Icons.gpp_good_sharp,
                  size: 100,
                  color: Colors.green.shade200,
                )
              : const Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                  size: 100,
                ),
          ref.watch(userProvider).isLoading
              ? const CircularProgressIndicator()
              : GestureDetector(
                  onTap: () {
                    if (ref.read(userProvider.notifier).getEmail() !=
                        "로그인 해주세요.") {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TestScreen(),
                      ));
                    }
                  },
                  child: Text(
                    ref.read(userProvider.notifier).getEmail(),
                    style: TextStyle(
                        color: Colors.amber.shade600,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: _emailTextEditingController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value != null || value != "") {
                return "check Your Email";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: _passwordTextEditingController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null || value != "") {
                return "It is Not Safe";
              } else {
                return null;
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  disabledColor: Colors.grey,
                  color: Colors.green.shade500,
                  onPressed: _onTapLogin,
                  child: const Text("로그인"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CupertinoButton(
                  disabledColor: Colors.grey,
                  color: Colors.red.shade500,
                  onPressed: _onTapLogout,
                  child: const Text("로그아웃"),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
              disabledColor: Colors.grey,
              color: Colors.blue.shade300,
              onPressed: _onTapCreateUser,
              child: const Text("회원으로 가입하기"),
            ),
          ),
        ],
      ),
    )));
  }
}
