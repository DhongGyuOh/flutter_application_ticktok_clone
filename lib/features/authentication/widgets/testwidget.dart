import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/test_mvvmtest.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/////////////////////////////Model
class UserInfo {
  final String uid;
  final String name;
  final String email;
  final String link;
  UserInfo({
    required this.uid,
    required this.name,
    required this.email,
    required this.link,
  });

  UserInfo.empty()
      : uid = "",
        name = "",
        email = "",
        link = "";

  UserInfo.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        name = json["name"],
        email = json["email"],
        link = json["link"];

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "link": link,
      };

  UserInfo copyWith({String? name, String? email, String? link, String? uid}) {
    //copyWith: 원본 객체를 유지하면서, 특정 속성에 지정된 값을 갖는 객체를 생성할 때 사용함(Flutter에서 자주 사용되는 개념)
    //예시1) UserInfo 객체의 틀을 그대로 사용하면서 name이 "Gyu"인 객체를 생성할 때
    //예시2) 지정된 ThemeData 에서 색이나 크기만 변경해서 쓰고싶을때
    //이미있는 객체를 복사한뒤, 사본을 만들고 바꾸고싶은 값만 재정의해서 사용하는 개념,
    //따라서 기존 객체의 데이터에 영향을 주지않음
    return UserInfo(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        link: link ?? this.link);
  }
}

///////////////////////////Repository
class UserInfoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //사용될 firestore => db와 storage instance를 생성함

  //firestore컬랙션 생성 메소드
  Future<void> createUserInfo(UserInfo userInfo) async {
    await _firestore
        .collection("userInfo")
        .doc(userInfo.uid)
        .set(userInfo.toJson());
  }

  //uid로 firestore에 있는 userInfo 컬랙션을 조회하여 데이터를 가져오는 메서드
  Future<Map<String, dynamic>?> findUserInfo(String uid) async {
    final doc = await _firestore.collection("userInfo").doc(uid).get();
    return doc.data();
  }

  //uid로 firestore에 있는 userInfo 컬랙션에 data로 update하는 메서드
  Future<void> updateUserInfo(String uid, Map<String, dynamic> data) async {
    await _firestore.collection("userInfo").doc(uid).update(data);
  }
}

final userInfoRepoProvider = Provider((ref) => UserInfoRepository());

///////////////////////////ViewModel
class UserInfoViewModel extends AsyncNotifier<UserInfo> {
  late final UserInfoRepository _userInfoRepository;
  late final AuthRepository _authRepository;
  //ViewModel에서 사용될 Repository 선언
  @override
  //ViewModel 초기화 메서드 build()
  FutureOr<UserInfo> build() async {
    _authRepository = ref.read(authRepoProvider);
    _userInfoRepository = ref.read(userInfoRepoProvider);
    //Repositiory 초기화
    if (_authRepository.isLoggedIn) {
      final userInfo =
          await _userInfoRepository.findUserInfo(_authRepository.user!.uid);
      //이미 로그인되어있다면, .findUserInfo에 uid로 조회하여 userInfo 데이터를 받아옴
      if (userInfo != null) {
        return UserInfo.fromJson(userInfo);
        //받아온 userInfo에 데이터가 있다면 UserInfo를 return함
      }
    }
    return UserInfo.empty();
    //로그인되어있지 않다면 비어있는 UserInfo를 return함
  }

  //userInfo를 생성하는 메서드
  Future<void> createAccount(UserCredential userCredential) async {
    //firbaseAuth의 createUserWithEmailAndPassword()로
    //return된 값을 이용하기 위해 UserCredential를 para값으로 받음
    if (userCredential.user == null) throw Exception("Account not created");
    state = const AsyncValue.loading();
    final userInfo = UserInfo(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? "NoName",
        email: userCredential.user!.email ?? "NoEmail",
        link: ref.read(userInfoProvider).value?.link ?? "NoLink");
    _userInfoRepository.createUserInfo(userInfo);
    //firebase UserInfo 컬랙션생성
    state = AsyncValue.data(userInfo);
    //생성된 userInfo를 state에 넣음
  }

  Future<void> setUserName(String name) async {
    state = const AsyncValue.loading();
    final user = state.value!.copyWith(name: name);
    await _userInfoRepository.updateUserInfo(user.uid, {"name": name});
    //UserInfo 컬랙션, 다큐먼트 uid에 입력받은 name 업데이트
    final updatedUserInfo = await _userInfoRepository.findUserInfo(user.uid);
    //업데이트된 정보를 다시 가져오기 위해 findUserInfo 호출
    state = AsyncValue.data(UserInfo.fromJson(updatedUserInfo!));
  }

  Future<void> setUserLink(String link) async {
    state = const AsyncValue.loading();
    final user = state.value!.copyWith(link: link);
    await _userInfoRepository.updateUserInfo(user.uid, {"link": link});
    //UserInfo 컬랙션, 다큐먼트 uid에 입력받은 link 업데이트
    final updatedUserInfo = await _userInfoRepository.findUserInfo(user.uid);
    //업데이트된 정보를 다시 가져오기 위해 findUserInfo 호출
    state = AsyncValue.data(UserInfo.fromJson(updatedUserInfo!));
  }
}

final userInfoProvider = AsyncNotifierProvider<UserInfoViewModel, UserInfo>(
    () => UserInfoViewModel());
//UserInfoViewModel과 UserInfo를 View에 expose하기 위한 Provider 생성

//////////////////////////View
class TestScreen extends ConsumerStatefulWidget {
  static String routeName = "testwidget";
  static String routeURL = "/testwidget";
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
          data: (data) {
            return Scaffold(
              body: Stack(
                children: [
                  Positioned(
                      top: 30,
                      right: 30,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TestScreen2(),
                        )),
                        child: const Icon(
                          Icons.mode_edit_outline_outlined,
                          size: 40,
                        ),
                      )),
                  Center(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 70, bottom: 20),
                          child: CircleAvatar(
                            radius: 150,
                            backgroundColor: Colors.amber,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ref.watch(userInfoProvider).value!.name,
                              style: const TextStyle(fontSize: 40),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ref.watch(userInfoProvider).value!.email,
                              style: const TextStyle(fontSize: 40),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: 2.9,
                              child: Icon(
                                Icons.link,
                                size: 32,
                                color: Colors.blue.shade400,
                              ),
                            ),
                            Text(
                              ref.watch(userInfoProvider).value!.link,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () => const CircularProgressIndicator(),
        );
  }
}
