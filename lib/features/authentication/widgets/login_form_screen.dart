import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/gaps.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/view_models/login_view_model.dart';
import 'package:flutter_application_ticktok_clone/features/authentication/widgets/form_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/sizes.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});
  static String routeName = "/loginform";
  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref
            .read(loginProvider.notifier)
            .login(formData['email']!, formData['password']!, context);
        //context.goNamed(InterestScreen.routeName);
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => const InterestScreen()),
        //   (route) => false,
        // );
      }
    }
    //_formKey.currentState?.validate();
  }

  void onScreenTap() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onScreenTap(),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Log in",
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
                  onSaved: (newValue) =>
                      formData['email'] = newValue.toString(),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Wrong Email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2)))),
              Gaps.v20,
              TextFormField(
                onSaved: (newValue) =>
                    formData['password'] = newValue.toString(),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Wrong Password";
                  }
                  return null;
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
                  child:
                      FormButton(disabled: ref.watch(loginProvider).isLoading))
            ]),
          ),
        ),
      ),
    );
  }
}
