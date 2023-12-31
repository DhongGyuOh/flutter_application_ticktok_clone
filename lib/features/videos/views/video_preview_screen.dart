import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

import '../view_models/upload_video_view_model.dart';

class VideoPreViewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;
  const VideoPreViewScreen(
      {super.key, required this.video, required this.isPicked});

  @override
  VideoPreViewScreenState createState() => VideoPreViewScreenState();
}

class VideoPreViewScreenState extends ConsumerState<VideoPreViewScreen> {
  late final VideoPlayerController _videoPlayerController;

  late bool _isSavedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
      //VideoRecordingScreen()에서 녹화된 video를 받아 file path를 VideoPlayerController()에 넣음
    );
    await _videoPlayerController.initialize();
    //VideoPlayer 컨트롤러 초기화o player had error com.google.android.exoplayer2.ExoPlaybackException: Source error, null, null))
    await _videoPlayerController.setLooping(true);
    //loop 하도록 설정
    await _videoPlayerController.play();
    // 비디오 재생
    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_isSavedVideo) return;

    await GallerySaver.saveVideo(widget.video.path, albumName: "MyFlutterApp");
    //albumName이 디렉토리명이 됨
    _isSavedVideo = true;
    setState(() {});
  }

  void _onUploadPressed() async {
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.video.path),
          context,
        );
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: _videoPlayerController.value.isInitialized
          ? Stack(alignment: Alignment.bottomCenter, children: [
              VideoPlayer(_videoPlayerController),
              if (!widget.isPicked)
                Positioned(
                    bottom: MediaQuery.of(context).size.height / 18,
                    child: GestureDetector(
                      onTap: () => _saveToGallery(),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isSavedVideo
                                ? Colors.green.shade400
                                : Colors.blue.shade300),
                        child: Icon(
                          _isSavedVideo ? Icons.download_done : Icons.download,
                          size: 40,
                        ),
                      ),
                    )),
              Positioned(
                top: 10,
                right: 20,
                child: IconButton(
                    onPressed: ref.watch(uploadVideoProvider).isLoading
                        ? () {}
                        : _onUploadPressed,
                    icon: ref.watch(uploadVideoProvider).isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(
                            Icons.cloud_upload,
                          )),
              )
            ])
          : null,
    );
  }
}
