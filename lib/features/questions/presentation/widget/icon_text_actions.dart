import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';

Widget iconTextAction(
  TextTheme textTheme,
  Widget icon,
  String text,
  void Function()? onPressed,
) {
  return Container(
    margin: EdgeInsets.only(left: 1.w, right: 1.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              icon,
              SizedBox(width: 1.w),
              (text != '')
                  ? Text(
                      formatNumber(int.parse(text.toString())),
                      style: textTheme.labelSmall!.copyWith(
                        color: black,
                        fontSize: 14.sp,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    ),
  );
}

String formatNumber(int number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    double result = number / 1000;
    return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}k';
  }
  return number.toString();
}
