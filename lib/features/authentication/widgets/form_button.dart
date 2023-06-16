import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({super.key, required this.disabled});
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(disabled ? 0 : 13),
          color:
              disabled ? Colors.grey.shade300 : Theme.of(context).primaryColor,
          //border: Border.all(color: Theme.of(context).primaryColor)
        ),
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
              color: disabled ? Colors.grey : Colors.white,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w500),
          duration: const Duration(milliseconds: 200),
          child: Text(
            disabled ? 'Sign Up' : 'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
