import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepositiory {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
  //Firebase 에게 currentUser가 있는지 물어봄

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}

final authRepo = Provider((ref) => AuthenticationRepositiory());
