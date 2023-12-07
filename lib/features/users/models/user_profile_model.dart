class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  //FirebaseAuth 에서 가져올 수 있는 값들을 모델로 만들어줌

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
  });
  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "";
}
