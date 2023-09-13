import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavTap extends StatelessWidget {
  const NavTap(
      {super.key,
      required this.title,
      required this.icon,
      required this.selectedIcon,
      required this.isSelected,
      required this.onTap,
      required this.selectedIndex});
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final Function onTap;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: selectedIndex == 0 ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: selectedIndex == 0 ? Colors.white : Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
