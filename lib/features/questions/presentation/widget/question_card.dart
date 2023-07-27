import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/utils/colors.dart';
import '../../domain/entity/question.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

import 'custom_cached_image.dart';
import 'profile_section.dart';

class QuestionCard extends StatelessWidget {
  final question;
  final Widget showActions;
  final bool showImage;
  final int descriptionLength;
  void Function()? onPressed;
  final bool isAnswer;

  QuestionCard(this.question,
      {super.key,
      this.descriptionLength = 3,
      required this.showActions,
      this.showImage = true,
      this.onPressed,
      this.isAnswer = false});

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
            profileSection(textTheme, fullName: question.userProfile.fullName,createdAt: question.createdAt,isAnonymous: question.runtimeType is Question ? question.isAnonymous : false,profilePicture: question.userProfile.profilePicture),
            InkWell(
              onTap: onPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  !isAnswer ? Text(
                    question.title,
                    style: textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ) : const SizedBox(),
                  SizedBox(
                    height: 1.h,
                  ),
                  ExpandableText(
                    question.description,
                    linkTextStyle:
                        textTheme.labelSmall!.copyWith(fontSize: 14.sp),
                    trim: descriptionLength,
                    
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  showImage && question.imageUrl != ""
                      ? CustomizedCachedImage(
                          imageURL: question.imageUrl,
                          width: double.infinity,
                          height: 35.h,
                          borderRadius: 4,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const Divider(
              color: white,
              thickness: 2,
            ),
            showActions
          ],
        ));
  }
}
