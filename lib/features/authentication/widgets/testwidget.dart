import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final listitem = [
    '탑건',
    '레옹',
    '웨스트 사이드 스토리',
    '태양은 없다',
    '번지점프를 하다',
    '빌리 엘리어트',
    '해리포터와 마법사의 돌',
    '센과 치히로의 행방불명',
    '그녀에게',
    '툼레이더 2 : 판도라의 상자',
    '하나와 앨리스',
    '해리포터와 아즈카반의 죄수',
    '릴리 슈슈의 모든 것',
    '초속5센티미터',
    '트랜스포머',
    '집오리와 들오리의 코인로커',
    '트와일라잇',
    '호우시절',
    '서칭 포 슈가맨',
    '피에타',
    '7번방의 선물',
    '변호인',
    '사이비',
    '겨울왕국',
    '국제시장',
    '비긴 어게인',
    '내부자들: 디 오리지널',
    '더폰',
    '도라에몽 : 스탠 바이 미',
    '러브 앤 머시',
    '맥베스',
    '미라클 벨리에',
    '뷰티인사이드',
    '극장판 파워레인저: 애니멀포스 VS 닌자포스 미래',
    '스물',
    '연평해전',
    '열정같은소리하고있네'
  ];
  final ScrollController _scrollController = ScrollController();
  late bool _appBarVisible = false;
  void _onScroll() {
    if (_scrollController.offset > 10) {
      setState(() {
        _appBarVisible = true;
      });
    } else {
      setState(() {
        _appBarVisible = false;
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _appBarVisible ? 1 : 0,
          child: const Text(
            "Movie List",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Movie List',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              Gaps.v32,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var item in listitem)
                    SizedBox(
                      height: 40,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 20),
                      ),
                    )
                ],
              )
            ],
          ),
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
