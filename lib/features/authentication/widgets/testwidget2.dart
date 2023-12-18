import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/testwidget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestScreen2 extends ConsumerStatefulWidget {
  static String routeName = "testwidget2";
  static String routeURL = "testwidget2";
  const TestScreen2({super.key});

  @override
  ConsumerState<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends ConsumerState<TestScreen2> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _linkEditingController = TextEditingController();

  @override
  void initState() {
    _nameEditingController.addListener(() {});
    _linkEditingController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _linkEditingController.dispose();
    super.dispose();
  }

  void _onPressed() {
    if (_nameEditingController.text == "" ||
        _linkEditingController.text == "") {
      return;
    }
    ref
        .read(userInfoProvider.notifier)
        .setUserName(_nameEditingController.text);
    ref
        .read(userInfoProvider.notifier)
        .setUserLink(_linkEditingController.text);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TestScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('정보 수정하기'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameEditingController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: "Name 입력",
                      prefixIcon: Icon(
                        Icons.person_sharp,
                        size: 32,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _linkEditingController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: "Link 입력",
                      prefixIcon: Icon(
                        Icons.link_sharp,
                        size: 32,
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                CupertinoButton(
                  color: Colors.red.shade400,
                  onPressed: _onPressed,
                  child: const Text("수정하기"),
                )
              ],
            ),
          ),
        ));
  }
}
