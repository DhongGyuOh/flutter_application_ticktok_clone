import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/features/videos/widgets/video_preview_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  //2개 이상의 Ticker가 필요하기 때문에 TickerProviderStateMixin 사용
  late bool _hasPermission = false;
  //앱 내 장치사용 권한
  late bool _isSelfieMode = false;
  //셀피모드 (카메라 전면, 후면 전환)
  late CameraController _cameraController;

  late FlashMode _flashMode;
  //플래시 모드(auto, off, on)

  late final AnimationController _buttonAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
          vsync: this,
          duration: const Duration(seconds: 5),
          lowerBound: 0.0,
          upperBound: 1.0);

  Future<void> _startRecording(TapDownDetails details) async {
    if (_cameraController.value.isRecordingVideo) return;
    //이미 녹화중이라면 return;
    await _cameraController.startVideoRecording();
    //아니라면 녹화 시작
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    //녹화중이 아니라면 return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    final video = await _cameraController.stopVideoRecording();
    //녹화를 멈춤

    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return VideoPreViewScreen(video: video);
      },
    ));
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    //사용 가능한 카메라 목록을 가져옴
    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
        //CameraController 설정
        cameras[_isSelfieMode ? 1 : 0],
        //CameraDescription(0,CameraLensDirection.back,90) 후면 카메라
        //CameraDescription(1,CameraLensDirection.front,270) 전면 카메라
        ResolutionPreset.ultraHigh,
        //매우 높은 화질 선택
        enableAudio: true,
        //오디오 녹음 활성화
        imageFormatGroup: ImageFormatGroup.jpeg
        //jpeg 이미지 형식 지정
        );

    await _cameraController.initialize();
    //카메라 초기화
    await _cameraController.prepareForVideoRecording();
    // IOS 운영체제에서 녹화할때 싱크를 맞추기 위해 필요한 소스한줄(안드로이드,Web 등은 필요없음)

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> initPermission() async {
    //비동기 함수를 사용하기 위해 Future를 사용해서 async
    final cameraPermission = await Permission.camera.request();
    //카메라 사용권한
    final micPermission = await Permission.microphone.request();
    //마이크 녹음 사용권한

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;
    //isDenied 이번만 허용하지 않음 선택(다시 요청함)
    //isPermanentlyDenied 항상 허용하지 않음 선택(요청하지 않음)

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();

      //카메라를 실행시키는 메소드를 호출시킴
      setState(() {});
    }
  }

  Future<void> toggleSelfiMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermission();
    //권한 허용을 묻는 팝업을 띄움
    _progressAnimationController.addListener(
      () {
        setState(() {});
      },
    );
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _hasPermission && _cameraController.value.isInitialized
              ? Stack(alignment: Alignment.center, children: [
                  CameraPreview(_cameraController),
                  Positioned(
                      top: MediaQuery.of(context).size.height / 40,
                      right: MediaQuery.of(context).size.width / 30,
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: toggleSelfiMode,
                              icon: FaIcon(
                                FontAwesomeIcons.cameraRotate,
                                color:
                                    _isSelfieMode ? Colors.blue : Colors.white,
                                size: 32,
                              )),
                          Gaps.v10,
                          IconButton(
                              onPressed: () => _setFlashMode(FlashMode.always),
                              icon: FaIcon(
                                Icons.flash_on,
                                color: _flashMode == FlashMode.always
                                    ? Colors.amber
                                    : Colors.white,
                                size: 32,
                              )),
                          Gaps.v10,
                          IconButton(
                              onPressed: () => _setFlashMode(FlashMode.auto),
                              icon: FaIcon(
                                Icons.flash_auto,
                                color: _flashMode == FlashMode.auto
                                    ? Colors.amber
                                    : Colors.white,
                                size: 32,
                              )),
                          Gaps.v10,
                          IconButton(
                              onPressed: () => _setFlashMode(FlashMode.off),
                              icon: FaIcon(
                                Icons.flash_off,
                                color: _flashMode == FlashMode.off
                                    ? Colors.amber
                                    : Colors.white,
                                size: 32,
                              )),
                          Gaps.v10,
                          IconButton(
                              onPressed: () => _setFlashMode(FlashMode.torch),
                              icon: FaIcon(
                                Icons.light_mode,
                                color: _flashMode == FlashMode.torch
                                    ? Colors.amber
                                    : Colors.white,
                                size: 32,
                              )),
                        ],
                      )),
                  Positioned(
                      bottom: 30,
                      child: GestureDetector(
                        onTapDown: _startRecording,
                        onTapUp: (details) => _stopRecording(),
                        child: ScaleTransition(
                          scale: _buttonAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                  strokeWidth: 5,
                                  value: _progressAnimationController.value,
                                ),
                              ),
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ])
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Initalizing'),
                    Gaps.v32,
                    CircularProgressIndicator.adaptive()
                  ],
                )),
    );
  }
}
