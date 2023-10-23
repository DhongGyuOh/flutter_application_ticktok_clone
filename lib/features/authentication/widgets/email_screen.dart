import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/form_button.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/password_screen.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});
  static String routeName = "/email";
  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    //Email 정규식
    if (!regExp.hasMatch(_email)) {
      return 'Sorry, that is not a valid Email Address';
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void onEmailTap(BuildContext context) {
    if (_email.isEmpty || _isEmailValid() != null) return;
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const PasswordScreen(),
    ));
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                "Your Email",
                style: TextStyle(
                    fontSize: Sizes.size28, fontWeight: FontWeight.bold),
              ),
              Gaps.v10,
              const Text(
                'You Can Always Change This Later.',
                style: TextStyle(color: Colors.grey),
              ),
              Gaps.v20,
              TextField(
                onSubmitted: (value) => onEmailTap(context),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,

                //문자열 수 10으로 제한
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]'))
                  //한글 입력 막기
                ],
                controller: _emailController,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    errorText: _isEmailValid(),
                    hintText: 'Insert Your Email Address',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              Gaps.v20,
              GestureDetector(
                  onTap: () => onEmailTap(context),
                  child: FormButton(
                      disabled: _email.isEmpty || _isEmailValid() != null))
            ],
          ),
        ),
      ),
    );
  }
}
