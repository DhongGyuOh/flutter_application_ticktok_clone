import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late bool _showFirstWidget = true;
  late bool _dragleft = true;
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _dragleft = true;
      });
    } else {
      setState(() {
        _dragleft = false;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dragleft) {
      setState(() {
        _showFirstWidget = true;
      });
    } else {
      setState(() {
        _showFirstWidget = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: AnimatedCrossFade(
              firstChild: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AnimatedCrossFade\nFirst Screen\n\nDrag Right to Left ←',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    ' As the waves crashed against the shore, the salty sea breeze filled the air, creating a soothing atmosphere that instantly put my mind at ease.',
                    style: TextStyle(fontSize: 20, color: Colors.indigo),
                  )
                ],
              ),
              secondChild: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AnimatedCrossFade\nSecond Screen\n\nDrag Left to Right →',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    "Walking through the bustling streets of the city, I couldn't help but be captivated by the vibrant sights and sounds that surrounded me, immersing myself in the energy of urban life.",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )
                ],
              ),
              crossFadeState: _showFirstWidget
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300)),
        ),
      ),
    );
  }
}

// enum Gneder { man, women }

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   Map<String, String> formData = {};
//   late bool? _checked = false;
//   Gneder? gneder = Gneder.man;
//   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
//   void onTapBtn() {
//     if (_globalKey.currentState == null) return;
//     _globalKey.currentState!.validate();
//     _globalKey.currentState!.save();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//             horizontal: Sizes.size28, vertical: Sizes.size36),
//         child: Form(
//           key: _globalKey,
//           child: Column(children: [
//             Gaps.v10,
//             TextFormField(
//               validator: (value) {
//                 if (value != null && value.isEmpty) {
//                   return "Check Your Email Address.";
//                 }
//                 return null;
//               },
//               onSaved: (newValue) => formData['email'] = newValue.toString(),
//               decoration: const InputDecoration(hintText: "Insert Your Email"),
//             ),
//             TextFormField(
//               validator: (value) {
//                 if (value != null && value.isEmpty) {
//                   return "Check Your Password.";
//                 }
//                 return null;
//               },
//               decoration: const InputDecoration(hintText: "Password"),
//             ),
//             SizedBox(
//               width: 150,
//               height: 50,
//               child: CheckboxListTile(
//                 title: const Text('Agree?'),
//                 value: _checked,
//                 onChanged: (value) {
//                   setState(() {
//                     _checked = value;
//                   });
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: 150,
//                   child: RadioListTile(
//                     title: const Text('Man'),
//                     value: Gneder.man,
//                     groupValue: gneder,
//                     onChanged: (value) {
//                       setState(() {
//                         gneder = value;
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   width: 150,
//                   child: RadioListTile(
//                     title: const Text('Women'),
//                     value: Gneder.women,
//                     groupValue: gneder,
//                     onChanged: (value) {
//                       setState(() {
//                         gneder = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             GestureDetector(
//               onTap: () => onTapBtn(),
//               child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
//                   decoration: const BoxDecoration(color: Colors.amber),
//                   child: const Text('Button')),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class WarpEx extends StatelessWidget {
//   const WarpEx({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Wrap(
//         direction: Axis.horizontal,
//         alignment: WrapAlignment.start,
//         spacing: 8.0,
//         runSpacing: 12.0,
//         runAlignment: WrapAlignment.center,
//         children: [
//           Container(
//             width: 100,
//             height: 50,
//             color: Colors.red,
//           ),
//           Container(
//             width: 80,
//             height: 80,
//             color: Colors.blue,
//           ),
//           Container(
//             width: 120,
//             height: 60,
//             color: Colors.green,
//           ),
//           // Add more child widgets as needed
//         ],
//       ),
//     );
//   }
// }
