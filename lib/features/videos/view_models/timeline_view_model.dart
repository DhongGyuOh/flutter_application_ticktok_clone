import 'dart:async';

import 'package:flutter_application_ticktok_clone/features/videos/models/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late List<VideoModel> _list = [];
  //API 연결전 영상 목록

  Future<void> uploadVideo() async {
    state = const AsyncValue.loading();
    //state를 loading 상태로 만들어줌
    await Future.delayed(const Duration(seconds: 2));
    //2초간 딜레이를 줌(API를 받는 것처럼 환경을 만들기 위함)
    _list = [..._list];
    //_list에 newVideo 추가
    state = AsyncValue.data(_list);
    //state를 _list 데이터로 바꿔줌
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    //API 응답시간이 2초라고 가정하는 상황설정
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  //TimelineViewModel의 Notifier를 Expose 할 것이고, 전달할 데이터는 List<VideoModel> 이다.
  () => TimelineViewModel(),
  //ViewModel을 초기화 해줄 Function 추가
);
