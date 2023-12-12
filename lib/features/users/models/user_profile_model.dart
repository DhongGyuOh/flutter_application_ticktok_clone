class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String birthday;
  final bool hasAvatar;
  //FirebaseAuth 에서 가져올 수 있는 값들을 모델로 만들어줌

  UserProfileModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.bio,
      required this.link,
      required this.birthday,
      required this.hasAvatar});
  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        birthday = "",
        hasAvatar = false;

  UserProfileModel.fromJson(Map<String, dynamic> json)
      //firestore에서 기존 uid를 찾아 정보를 json으로 받았을 때
      : uid = json["uid"],
        email = json["email"],
        name = json["name"],
        bio = json["bio"],
        link = json["link"],
        birthday = json["birthday"],
        hasAvatar = json["hasAvatar"] ?? false;

  Map<String, String> toJson() {
    //MAP을 이용하여 Json 형태로 리턴하기
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "birthday": birthday,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      birthday: birthday ?? this.birthday,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
