import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityScreen extends StatefulWidget {
  static String routeName = "/activity";
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  //매 애니메이션 프레임마다 호출되는 시계라고 생각하면됨 SingleTicker를 사용해서 리소스를 줄임
  final List<String> _notifications = List.generate(20, (index) => "${index}h");
  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];
  late bool _showBarrier = false;
  void _onDismissed(String notification) {
    //print(notification);
  }

  void _toggleAnimations() async {
    if (_animationController.isAnimating) return;
    if (_animationController.isCompleted) {
      await _animationController
          .reverse(); //_animationController가 완료되고 나오도록 await 해줌
    } else {
      _animationController.forward();
    }
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));

  late final Animation<double> _arrowAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);
  //Tween을 사용하여 시작과 끝을 정해주면되는 애니메이션을 만들 수 있음
  late final Animation<Offset> _offsetAnimation =
      Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
          .animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //_animationController.dispose(); dispose 할 필요 없음
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "All Activity",
              ),
              Gaps.h5,
              RotationTransition(
                alignment: Alignment.center,
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const Text("New"),
              Gaps.v10,
              for (var notification in _notifications)
                Dismissible(
                  onDismissed: (direction) => _onDismissed(notification),
                  key: Key(notification),
                  background: Container(
                    alignment: Alignment.center,
                    color: Colors.green.shade500,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: FaIcon(
                        FontAwesomeIcons.faceGrinWink,
                        size: 30,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.center,
                    color: Colors.red.shade400,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: FaIcon(
                        FontAwesomeIcons.faceFlushed,
                        size: 30,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: 12,
                    contentPadding: EdgeInsets.zero,
                    trailing: const FaIcon(FontAwesomeIcons.chevronRight),
                    leading: Container(
                      width: 52,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                          text: "Account Updates:",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                                text: "Upload longer Video.",
                                style: TextStyle(fontWeight: FontWeight.w400)),
                            TextSpan(
                                text: notification,
                                style: const TextStyle(color: Colors.grey))
                          ]),
                    ),
                  ),
                ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true, //dismissible을 true로 줘야 onDismiss의 메소드가 실행됨
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          SizedBox(width: 25, child: FaIcon(tab["icon"])),
                          Gaps.h10,
                          Text(
                            tab["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
