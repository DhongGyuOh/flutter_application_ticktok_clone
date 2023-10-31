import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreViewScreen extends StatefulWidget {
  final XFile video;
  const VideoPreViewScreen({super.key, required this.video});

  @override
  State<VideoPreViewScreen> createState() => _VideoPreViewScreenState();
}

class _VideoPreViewScreenState extends State<VideoPreViewScreen> {
  late final VideoPlayerController _videoPlayerController;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
      //VideoRecordingScreen()에서 녹화된 video를 받아 file path를 VideoPlayerController()에 넣음
    );
    await _videoPlayerController.initialize();
    //VideoPlayer 컨트롤러 초기화
    await _videoPlayerController.setLooping(true);
    //loop 하도록 설정
    await _videoPlayerController.play();
    // 비디오 재생
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
