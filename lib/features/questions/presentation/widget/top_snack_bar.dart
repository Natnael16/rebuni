import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';

void showTopSnackBar(BuildContext context, Widget widget) {
  final overlay = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => widget);

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}

class TopSnackBar extends StatelessWidget {
  final String message;
  final bool error;

  const TopSnackBar({super.key, required this.message, required this.error});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12.h,
      left:2.5.w,
      child: Container(
        height: 5.h,
        width: MediaQuery.of(context).size.width - 5.w,
        decoration: BoxDecoration(
            color: error ? Colors.red : primaryColor,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 28.w,
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
              
                message,
                overflow: TextOverflow.ellipsis,
                maxLines : 1,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                error ? Icons.cancel_outlined : Icons.check_circle_outline,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
