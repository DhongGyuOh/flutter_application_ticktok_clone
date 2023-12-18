import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepositiory {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
  //Firebase 에게 currentUser가 있는지 물어봄

  Stream<User?> authStateChange() => _firebaseAuth.authStateChanges();
  //실시간 변경을 감지하기위해 .authStateChanges()를 통해 받은 Stream 반환함수를 만들어 줌

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    //.createUserWithEmailAndPassword 를 실시간 유저 로그인 연결상태를 주고받음
  }

  Future<UserCredential> emailSignUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    //.signOut(): firebase의 로그아웃 메소드
  }

  Future<void> signIn(String email, String password) async {
    //.signInWithEmailAndPassword(): firebase 이메일,비밀번호 로그인
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }
}

final authRepo = Provider((ref) => AuthenticationRepositiory());

final authState = StreamProvider((ref) {
  //유저인증 상태 변화를 계속 감시하기 위해 Stream을 expose할수 있는 StreamProvider를 생성해줌
  final repo = ref.read(authRepo);
  return repo.authStateChange();
});
