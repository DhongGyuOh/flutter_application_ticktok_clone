import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/videos/models/playback_config_model.dart';
import 'package:flutter_application_ticktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final VideoPlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
      muted: _repository.isMuted(), autoplay: _repository.isAutoplay());

  PlaybackConfigViewModel(this._repository);

  bool get muted => _model.muted;
  //get도 구현해줌 값을 전달하기 위해
  bool get autoplay => _model.autoplay;

  void setMuted(bool value) {
    _repository.setMuted(value);
    //repository가 value 값을 디스크에 저장하게함 set
    _model.muted = value;
    //model의 값을 value로 수정함
    notifyListeners();
    //listen 하고 있는 화면에 값이 바뀌었다고 알림
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    _model.autoplay = value;
    notifyListeners();
  }
}
