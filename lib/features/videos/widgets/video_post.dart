import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost(
      {super.key, required this.onVideoFinished, required this.index});
  final Function onVideoFinished;
  final int index;
  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  //with와 Xixin을 사용하여 SingleTickerProviderStateMixin 클래스, 메서드를 복사해옴
  late final AnimationController _animationController;

  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/bromton2.mp4");

  bool _isPaused = true;

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    //_videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  void _onVideoChange() {
    _isPaused = true;
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  @override
  void initState() {
    _isPaused = true;
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      //vsync에 this, 즉 class _VideoPostState extends State<VideoPost>
      //with SingleTickerProviderStateMixin을 넣어서화면이 보일 때만
      //Tick하게 만들어주는 Ticker를 사용하여 불필요한 애니메이션 리소스를 막음
      //애니메이션을 만들때는 거의 필수라고 보면됨(리소스 남용방지)
      //AnimationController이 많을 경우 TickerProviderStateMixin을 with로 복사하면 됨
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    //print(info.visibleFraction);
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
      _isPaused = false;
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); //upperbound -> lower bound 로 변함
      _isPaused = false;
    } else {
      _videoPlayerController.play();
      _animationController.forward(); //lower bound -> upper bound 로 변함
      _isPaused = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
              child: GestureDetector(
            onTap: _onTogglePause,
          )),
          Positioned.fill(
              child: IgnorePointer(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  //값이 변할때마다 다시 빌드해줌 -> 리스너,setStae 안써도되는 효과
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child, //여기서 child는 아래 AnimatedOpacity을 말함
                  );
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _isPaused ? 0 : 1,
                  child: Icon(
                    FontAwesomeIcons.play,
                    size: Sizes.size64,
                    color: Colors.white.withAlpha(150),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
