import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:flutter_application_ticktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost(
      {super.key, required this.onVideoFinished, required this.index});
  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  //with: SingleTickerProviderStateMixin의 클래스, 메서드를 복사해옴
  //SingleTickerProviderStateMixin를 사용하여 _animationController를 initState에 정의해주고,
  // vsync에 this로 메핑해줌
  //화면에 보일때만 current tree가 활성화되어있을 때 tick을 함
  late final VideoPlayerController _videoPlayerController;

  late final AnimationController _animationController;
  bool isPaused = false;
  bool isDetail = false;
  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/bromton2.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        widget.onVideoFinished();
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !isPaused) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (!mounted) return;
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); //upperbound -> lowerbound로 변함
    } else {
      _videoPlayerController.play();
      _animationController.forward(); //lowerbound -> upperbound로 변함
    }
    isPaused = !isPaused;
    setState(() {});
  }

  void _onTapDetail() {
    isDetail = !isDetail;
    setState(() {});
  }

  @override
  void initState() {
    _initVideoPlayer();
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        //vsyn에 this: class _VideoPostState extends State<VideoPost>를 의미
        //with SingleTickerProviderStateMixin을 넣어서화면이 보일 때만
        //Tick하게 만들어주는 Ticker를 사용하여 불필요한 애니메이션 리소스를 막음
        //애니메이션을 만들때는 거의 필수라고 보면됨(리소스 남용방지)
        //AnimationController이 많을 경우 TickerProviderStateMixin을 with로 복사하면 됨
        lowerBound: 1.0,
        upperBound: 1.5,
        value: 1.5,
        duration: const Duration(milliseconds: 200));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    //muted에 따라 음소거 상태 관리하기

    if (ref.read(playbackConfigProvider).muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      //barrierColor: Colors.amber,
      isScrollControlled: true,
      builder: (context) => const VideoComments(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final automute = VideoConfigData.of(context).autoMute;
    //context를 통해 VideoConfig의 속성들을 받을 수 있음.
    return VisibilityDetector(
      key: Key("${widget.index}"),
      //Key에 부모인 class의 Key값인 index를 String값으로 넣기위해 위와같이 작성
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
              child: _videoPlayerController.value.isInitialized
                  ? VideoPlayer(_videoPlayerController)
                  : Container(
                      color: Colors.green,
                    )),
          Positioned.fill(
              child: GestureDetector(
            onTap: () => _onTogglePause(),
          )),
          Positioned.fill(
              child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationController.value,
                  child: child,
                  //child: child 는 AnimatedBuilder의 child인 아래 AnimatedOpacity 위젯을 말함
                );
              },
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isPaused ? 1 : 0,
                child: Center(
                  child: FaIcon(
                    isPaused ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
            ),
          )),
          Positioned(
              left: 10,
              top: 30,
              child: IconButton(
                  onPressed: _onPlaybackConfigChanged,
                  icon: Icon(
                    ref.watch(playbackConfigProvider).muted
                        ? Icons.volume_off
                        : Icons.volume_up,
                    size: 32,
                  ))),
          Positioned(
              bottom: 30,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                textDirection: TextDirection.ltr,
                children: [
                  const Text(
                    "@Bromton",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size16),
                  ),
                  Gaps.v11,
                  GestureDetector(
                    onTap: _onTapDetail,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 200,
                      decoration: const BoxDecoration(),
                      child: AnimatedSize(
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          "This Picture is BWCK in 2023 \nIt was Awsome \nMy Number is 222 \nI have M6R from 2020 \nIt's Rainning Day ",
                          style: const TextStyle(
                              color: Colors.white, fontSize: Sizes.size14),
                          maxLines: isDetail ? null : 2,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    foregroundImage: NetworkImage(
                        "https://yt3.ggpht.com/LOWZ9per6hyhd6swd5KEi_RmgACl6-gpXSUf91zNaY-fPb8jX13syeVo-RKLFqqUxnyqCi4S=s88-c-k-c0x00ffffff-no-rj"),
                    child: Text("Gyu"),
                  ),
                  Gaps.v10,
                  const VideoButton(
                      icon: FontAwesomeIcons.solidHeart, text: "2.9M"),
                  Gaps.v10,
                  GestureDetector(
                    onTap: () => _onCommentsTap(context),
                    child: const VideoButton(
                        icon: FontAwesomeIcons.solidCommentDots, text: "33K"),
                  ),
                  Gaps.v10,
                  const VideoButton(
                      icon: FontAwesomeIcons.share, text: "Share"),
                ],
              ))
        ],
      ),
    );
  }
}
