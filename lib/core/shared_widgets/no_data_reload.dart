import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebuni/core/shared_widgets/custom_round_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/images.dart';

class NoDataReload extends StatelessWidget {
  final void Function()? onPressed;
  final double? height;
  final double? width;

  const NoDataReload({super.key, required this.onPressed, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          noDataImage,
          height: height ?? 30.h,
          width: width ?? 15.h,
        ),
         SizedBox(height: 3.h),
        Text('No data found please reload.', style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 3.h),
        CustomRoundButton(
            borderRadius: 4, buttonText: "Reload", onPressed: onPressed)
      ],
    );
  }
}
