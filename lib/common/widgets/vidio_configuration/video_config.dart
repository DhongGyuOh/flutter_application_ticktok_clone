import 'package:flutter/foundation.dart';

final videoConfig = ValueNotifier(false);
//하나의 변수만 지원함

// class VideoConfig extends ChangeNotifier {
//   bool autoMute = true;

//   void toggleAutoMute() {
//     autoMute = !autoMute;
//     notifyListeners();
//     //바뀌었다고 알려주기
//   }
// }

// final videoConfig = VideoConfig();

////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';

// class VideoConfigData extends InheritedWidget {
//   final bool autoMute;
//   final void Function() toggleMuted;
//   const VideoConfigData(
//       {super.key,
//       required super.child,
//       required this.autoMute,
//       required this.toggleMuted});

//   static VideoConfigData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
// }

// class VideoConfig extends StatefulWidget {
//   final Widget child;
//   const VideoConfig({super.key, required this.child});

//   @override
//   State<VideoConfig> createState() => _VideoConfigState();
// }

// class _VideoConfigState extends State<VideoConfig> {
//   late bool autoMute = false;
//   void toggleMuted() {
//     setState(() {
//       autoMute = !autoMute;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoConfigData(
//         toggleMuted: toggleMuted, autoMute: autoMute, child: widget.child);
//   }
// }
