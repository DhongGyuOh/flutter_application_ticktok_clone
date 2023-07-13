import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  late int _itemCount = 7;
  final List<Color> _color = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.deepPurpleAccent
  ];
  final PageController _pageController = PageController();

  void _onVideoFinished() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        curve: Curves.linear, duration: const Duration(milliseconds: 100));
    if (page == _itemCount - 1) {
      setState(() {
        _itemCount += 4;
        _color.addAll([Colors.grey, Colors.lime, Colors.pink, Colors.teal]);
      });
    }
  }

  @override
  void initState() {
    _pageController.addListener(() {
      _onPageChanged;
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: _itemCount,
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) =>
          VideoPost(onVideoFinished: _onVideoFinished),
    );
  }
}
