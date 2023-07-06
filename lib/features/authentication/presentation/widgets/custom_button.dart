import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.buttonText, required this.borderRadius, super.key, this.onPressed});
  final double borderRadius;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 85.w,
        height: 6.h,
        padding: EdgeInsets.symmetric(horizontal: (4).w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: primaryColor,
        ),
        child: Center(
          child: Text(buttonText, style: Theme.of(context).textTheme.labelMedium),
        ),
      ),
    );
  }
}
