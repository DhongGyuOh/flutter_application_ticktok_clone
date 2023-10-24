import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestScreen extends StatefulWidget {
  static String routeName = 'test';
  static String routeURL = 'test';
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _controller = TextEditingController();
  late String _text = "";
  late bool _type = false;
  void onTap(BuildContext context) {
    context.pushNamed('test2',
        pathParameters: {"value": _text},
        queryParameters: {"type": _type ? "체크함" : "체크안함"});
  }

  void _onCheck() {
    setState(() {
      _type = !_type;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _text = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('다음 페이지에 전달할 값을 입력'),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _controller,
                )),
            CupertinoButton(
                onPressed: () => onTap(context), child: const Text('클릭')),
            Checkbox(
              value: _type,
              onChanged: (value) => _onCheck(),
            )
          ],
        ),
      ),
    );
  }
}
