import 'package:flutter_application_ticktok_clone/features/videos/models/playback_config_model.dart';
import 'package:flutter_application_ticktok_clone/features/videos/repos/video_playback_config_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final VideoPlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMutedValue(value);
    state = PlaybackConfigModel(muted: value, autoplay: state.autoplay);
    //state 사용자에게 노출시킬 데이터
  }

  void setAutoplay(bool value) {
    _repository.setAutoplayValue(value);
    state = PlaybackConfigModel(muted: state.muted, autoplay: value);
  }

  @override
  PlaybackConfigModel build() {
    //화면이 갖게 될 초기의 데이터
    return PlaybackConfigModel(
        muted: _repository.isMuted(), autoplay: _repository.isAutoplay());
    //Model에 Repository를 이용하여 기기에 저장된 값을 가져와 초기 데이터로 지정
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
        //Vid
        () => throw UnimplementedError());
