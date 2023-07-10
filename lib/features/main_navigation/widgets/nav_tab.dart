import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavTap extends StatelessWidget {
  const NavTap(
      {super.key,
      required this.title,
      required this.icon,
      required this.isSelected,
      required this.onTap});
  final String title;
  final IconData icon;
  final bool isSelected;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: Colors.red,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  icon,
                  color: Colors.white,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
