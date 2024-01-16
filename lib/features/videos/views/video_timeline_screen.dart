import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/widgets/video_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  static String routeName = "/videotimeline";
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
    if (page == _itemCount - 1) {
      ref.watch(timelineProvider.notifier).fetchNextPage();
      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
    // _pageController.nextPage(
    //duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load videos: $error',
            ),
          ),
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              displacement: 50,
              edgeOffset: 20,
              child: PageView.builder(
                controller: _pageController,
                pageSnapping: true,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    index: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
        );
  }
}
