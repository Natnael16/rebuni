import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../domain/entity/question.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

import 'question_actions.dart';
import 'custom_cached_image.dart';
import 'profile_section.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        decoration: const BoxDecoration(
          color: containerBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileSection(textTheme, question),
            SizedBox(
              height: 1.h,
            ),
            Text(
              question.title,
              style: textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 1.h,
            ),
            ExpandableText(
              linkTextStyle: textTheme.labelSmall!.copyWith(fontSize: 14.sp),
              trim: 3,
              question.description,
              style: textTheme.bodySmall,
            ),
            SizedBox(
              height: 1.h,
            ),
            question.imageUrl != ""
                ? CustomizedCachedImage(
                    imageURL: question.imageUrl,
                    width: double.infinity,
                    height: 35.h,
                    borderRadius: 4,
                  )
                : const SizedBox(),
          
            const Divider(color: white,thickness: 2,),
           
            actionsSection(textTheme, question,true)
          ],
        ));
  }
}
