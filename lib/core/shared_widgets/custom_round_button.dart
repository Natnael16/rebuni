import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colors.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton(
      {required this.buttonText,
      required this.borderRadius,
      super.key,
      this.onPressed});
  final double borderRadius;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 33.w,
        height: 5.h,
        padding: EdgeInsets.symmetric(horizontal: (4).w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: primaryColor,
        ),
        child: Center(
          child:
              Text(buttonText, style: Theme.of(context).textTheme.labelMedium),
        ),
      ),
    );
  }
}
