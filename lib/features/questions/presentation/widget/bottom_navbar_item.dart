import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBarItem buildBottomNavigationBarItem(
    IconData iconData, String label, String asset, Color activeColor) {
  return BottomNavigationBarItem(
    label: label,
    icon: SvgPicture.asset(asset),
    activeIcon: Container(
      padding: const EdgeInsets.all(5),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        color: const Color.fromARGB(255, 198, 231, 220),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(asset, color: activeColor),
    ),
  );
}
