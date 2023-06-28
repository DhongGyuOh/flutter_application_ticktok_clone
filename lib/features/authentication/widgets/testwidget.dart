import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';

enum Gneder { man, women }

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Map<String, String> formData = {};
  late bool? _checked = false;
  Gneder? gneder = Gneder.man;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  void onTapBtn() {
    if (_globalKey.currentState == null) return;
    _globalKey.currentState!.validate();
    _globalKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size28, vertical: Sizes.size36),
        child: Form(
          key: _globalKey,
          child: Column(children: [
            Gaps.v10,
            TextFormField(
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Check Your Email Address.";
                }
                return null;
              },
              onSaved: (newValue) => formData['email'] = newValue.toString(),
              decoration: const InputDecoration(hintText: "Insert Your Email"),
            ),
            TextFormField(
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Check Your Password.";
                }
                return null;
              },
              decoration: const InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: CheckboxListTile(
                title: const Text('Agree?'),
                value: _checked,
                onChanged: (value) {
                  setState(() {
                    _checked = value;
                  });
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: RadioListTile(
                    title: const Text('Man'),
                    value: Gneder.man,
                    groupValue: gneder,
                    onChanged: (value) {
                      setState(() {
                        gneder = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RadioListTile(
                    title: const Text('Women'),
                    value: Gneder.women,
                    groupValue: gneder,
                    onChanged: (value) {
                      setState(() {
                        gneder = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => onTapBtn(),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const Text('Button')),
            ),
          ]),
        ),
      ),
    );
  }
}
