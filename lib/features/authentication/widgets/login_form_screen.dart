import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/form_button.dart';

import '../../../constants/sizes.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};
  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
      _formKey.currentState!.save();
    }
    //_formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Log in",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size32, vertical: Sizes.size10),
        child: Form(
          key: _formKey,
          child: Column(children: [
            Gaps.v28,
            TextFormField(
                onSaved: (newValue) => formData['email'] = newValue.toString(),
                validator: (value) {
                  return "Wrong Email";
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2)))),
            Gaps.v20,
            TextFormField(
              onSaved: (newValue) => formData['password'] = newValue.toString(),
              validator: (value) {
                return "Wrong Password";
              },
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2))),
            ),
            Gaps.v28,
            GestureDetector(
                onTap: () => _onSubmitTap(),
                child: const FormButton(disabled: false))
          ]),
        ),
      ),
    );
  }
}
