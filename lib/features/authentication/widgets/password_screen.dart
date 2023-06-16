import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/form_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool obscure = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void onClearTap() {
    _passwordController.clear();
  }

  void onEyeTap() {
    obscure = !obscure;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size32, vertical: Sizes.size10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Password",
                style: TextStyle(
                    fontSize: Sizes.size28, fontWeight: FontWeight.bold),
              ),
              Gaps.v20,
              TextField(
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]'))
                  //한글 입력 막기
                ],
                obscureText: obscure,
                controller: _passwordController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    suffix: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => onClearTap(),
                          child: FaIcon(
                            FontAwesomeIcons.deleteLeft,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: () => onEyeTap(),
                          child: FaIcon(
                            obscure
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                    hintText: 'Make It Strong !',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              Gaps.v20,
              const Text(
                'Your password must have',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Sizes.size16),
              ),
              Gaps.v14,
              const Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: Colors.green,
                  ),
                  Gaps.h10,
                  Text('8 to 20 Characters')
                ],
              ),
              Gaps.v4,
              const Row(children: [
                FaIcon(FontAwesomeIcons.circleCheck, color: Colors.green),
                Gaps.h10,
                Text('Letters, Numbers, And Special Characters')
              ]),
              Gaps.v16,
              FormButton(disabled: _password.isEmpty)
            ],
          ),
        ),
      ),
    );
  }
}
