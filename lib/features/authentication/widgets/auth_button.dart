import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  const AuthButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.grey.shade300, width: Sizes.size2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10, horizontal: Sizes.size20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: icon),
              Text(
                text,
                style: const TextStyle(
                    fontSize: Sizes.size16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
