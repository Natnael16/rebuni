import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/images.dart';

Widget actionsSection(
  TextTheme textTheme, {
  required int upvoteCount,
  required int downvoteCount,
   int? numberOfAnswers,
   int? numberOfDiscussions,
   int? numberOfReplies,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              iconTextAction(
                textTheme,
                const Icon(Icons.thumb_up_outlined, color: primaryColor),
                upvoteCount.toString(),
                () {},
                const Key('thumbUpIcon'),
              ),
              Container(height: 30, width: 2, color: containerBackgroundColor),
              iconTextAction(
                textTheme,
                const Icon(Icons.thumb_down_outlined, color: primaryColor),
                downvoteCount.toString(),
                () {},
                const Key('thumbDownIcon'),
              ),
            ],
          ),
        ),
        numberOfAnswers != null ? iconTextAction(
          textTheme,
          SvgPicture.asset(
            answerIconImage,
            height: 2.5.h,
            width: 23,
            color: primaryColor,
          ),
          numberOfAnswers.toString(),
          () {},
          const Key('answerIcon'),
        ) : const SizedBox(),

        numberOfDiscussions != null ?iconTextAction(
          textTheme,
          const Icon(
            Icons.question_answer_outlined,
            color: primaryColor,
          ),
          numberOfDiscussions.toString(),
          () {},
          const Key('questionAnswerIcon'),
        ) : const SizedBox(),
        numberOfReplies != null
            ? iconTextAction(
                textTheme,
                const Icon(
                  Icons.reply_rounded,
                  color: primaryColor,
                ),
                numberOfReplies.toString(),
                () {},
                const Key('questionAnswerIcon'),
              )
            : const SizedBox(),

        iconTextAction(
          textTheme,
          const Icon(
            Icons.bookmark_border,
            color: primaryColor,
          ),
          '',
          () {},
          const Key('bookmarkIcon'),
        ),
      ],
    ),
  );
}

Widget iconTextAction(
  TextTheme textTheme,
  Widget icon,
  String text,
  void Function()? onPressed,
  Key key,
) {
  return Container(
    margin: EdgeInsets.only(left: 1.w, right: 1.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(15),
    ),
    key: key,
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
                      formatNumber(int.parse(text)),
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