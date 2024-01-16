import 'dart:async';

import 'package:flutter_application_ticktok_clone/features/videos/models/video_model.dart';
import 'package:flutter_application_ticktok_clone/features/videos/repos/videos_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchVideos(lastItemCreatedAt: null);
    //map: 제공되는 QueryDocumentSnapshot을 이용하여 map안에 정의된 return 값으로 새로운 list를 생성해줌 //foreach 같은 함수인듯
    final videos = result.docs.map((doc) {
      return VideoModel.fromJason(doc.data());
    });
    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    //VideoRepository 초기화
    _repository = ref.read(videosRepo);
    //fetchVideos() 메소드로 가져온 Video들을 result에 담음, result는 document들의 리스트가 됨
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  fetchNextPage() async {
    //await _repository.fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    //기존 _list에 nextPage 리스트를 합침
    state = AsyncValue.data([..._list, ...nextPage]);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
