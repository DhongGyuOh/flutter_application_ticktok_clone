import 'package:shared_preferences/shared_preferences.dart';

class VideoPlaybackConfigRepository {
  //디스크 데이터를 읽고 쓰는 역할 repository
  //디스크 데이터를 읽고 쓰기 위해 SharedPreferences 패키지가 필요함
  static const String _autoplay = "autoplay";
  static const String _muted = "muted";
  //key 이름 휴먼에러를 방지하기위해 변수로 선언함
  final SharedPreferences _preferences;
  //SharedPreferences: 기기 내부에 데이터를 저장하는 패키지 get, set 으로 값을 불러오거나 저장함
  VideoPlaybackConfigRepository(this._preferences);

  Future<void> setMutedValue(bool value) async {
    await _preferences.setBool(_muted, value);
    //디스크에 muted 정보를 저장함
  }

  Future<void> setAutoplayValue(bool value) async {
    await _preferences.setBool(_autoplay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
    //디스크의 muted 정보를 읽음 null이면(없으면) false로 리턴
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
