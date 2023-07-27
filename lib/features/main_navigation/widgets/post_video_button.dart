import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  PostVideoButton({super.key, required this.isSelected});
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Positioned(
        right: 20,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 30,
          width: 25,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size8,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xff61D4F0)
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              Sizes.size8,
            ),
          ),
        ),
      ),
      Positioned(
        left: 20,
        child: Container(
          height: 30,
          width: 25,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size8,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : const Color(0xff61D4F0),
            borderRadius: BorderRadius.circular(
              Sizes.size8,
            ),
          ),
        ),
      ),
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 30,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size6,
          ),
        ),
        child: const Center(
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.black,
            size: 18,
          ),
        ),
      )
    ]);
  }
}
