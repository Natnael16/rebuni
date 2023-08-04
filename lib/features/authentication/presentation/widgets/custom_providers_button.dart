import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';

class ProviderButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Widget icon;
  const ProviderButtons(
      {super.key, required this.icon, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 85.w,
        height: 7.h,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.circular(5),
          color: white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 2.w),
            Text(buttonText, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
