import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TestScreen2 extends StatefulWidget {
  final video;
  const TestScreen2({super.key, required this.video});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));
    super.initState();
    _videoPlayerController.initialize();
    _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video PreView'),
        ),
        body: Center(child: VideoPlayer(_videoPlayerController)));
  }
}
