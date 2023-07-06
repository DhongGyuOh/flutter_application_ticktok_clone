import 'package:flutter/material.dart';
import 'package:flutter_application_ticktok_clone/constants/sizes.dart';

class InterestsButton extends StatefulWidget {
  const InterestsButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestsButton> createState() => _InterestsButtonState();
}

class _InterestsButtonState extends State<InterestsButton> {
  late bool _isSelected = false;
  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.size14, horizontal: Sizes.size14),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size32),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 5,
                  spreadRadius: 5)
            ]),
        child: Text(
          widget.interest,
          style: TextStyle(
              color: _isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
