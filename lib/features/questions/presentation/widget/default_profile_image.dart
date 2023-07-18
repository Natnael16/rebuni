import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';

class DefaultProfileImage extends StatelessWidget {
  final String name;
  const DefaultProfileImage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      endRadius: 100.0,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: const Duration(milliseconds: 100),
      child: CircleAvatar(
        backgroundColor: getColorForLetter(name[0]),
        radius: 3.5.h,
        child: Text(
          getInitials(name),
          style: TextStyle(fontSize: 18.sp),
        ),
        
      ),
    );
  }

  String getInitials(String fullName) {
    final nameSplit = fullName.split(' ');
    String initials = '';

    if (nameSplit.isNotEmpty) {
      initials += nameSplit[0][0].toUpperCase();
      if (nameSplit.length > 1) {
        initials += nameSplit[nameSplit.length - 1][0].toUpperCase();
      }
    }

    return initials;
  }

  Color getColorForLetter(String letter) {
    int number = 0;
    for (var char in letter.runes) {
      number += char;
    }

    return letterColors['${(number % 26) + 1}'] ?? Colors.grey;
  }
}
