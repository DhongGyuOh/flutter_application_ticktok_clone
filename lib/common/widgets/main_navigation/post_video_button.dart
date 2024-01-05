import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/sizes.dart';
import 'package:flutter_application_ticktok_clone/utils.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton(
      {super.key, required this.isSelected, required this.selectedIndex});
  final bool isSelected;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    final bool isdarkMode = isDarkMode(context);
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
          color: selectedIndex == 0 || isdarkMode ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(
            Sizes.size6,
          ),
        ),
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.plus,
            color:
                selectedIndex == 0 || isdarkMode ? Colors.black : Colors.white,
            size: 18,
          ),
        ),
      )
    ]);
  }
}
