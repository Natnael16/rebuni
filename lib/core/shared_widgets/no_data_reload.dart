import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebuni/core/shared_widgets/custom_round_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colors.dart';
import '../utils/images.dart';

class NoDataReload extends StatelessWidget {
  final void Function()? onPressed;
  const NoDataReload({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(noDataImage,
           height: 30.h, width: 15.h,),
        SizedBox(height: 5.h),
        CustomRoundButton(
            borderRadius: 4, buttonText: "Reload", onPressed: onPressed)
      ],
    );
  }
}
