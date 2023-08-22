import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/routes/paths.dart' as path;
import '../../../../core/utils/colors.dart';
import '../../data/models/question_model.dart';
import '../../domain/entity/question.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

import 'custom_cached_image.dart';
import 'profile_section.dart';

class QuestionCard extends StatelessWidget {
  final dynamic question;
  final Widget showActions;
  final bool showImage;
  final bool showDivider;
  final int descriptionLength;
  void Function()? onPressed;
  final bool isAnswer;
  final bool isFormattedBody;
  final bool moreOptions;

  QuestionCard(this.question,
      {super.key,
      this.descriptionLength = 3,
      required this.showActions,
      this.showImage = true,
      this.showDivider = true,
      this.onPressed,
      this.moreOptions = true,
      this.isFormattedBody = false,
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
            profileSection(textTheme,
                moreOptions: moreOptions,
                fullName: question.userProfile.fullName,
                createdAt: question.createdAt,
                isAnonymous: question.runtimeType == QuestionModel || question.runtimeType == Question
                    ? question.isAnonymous
                    : false,
                profilePicture: question.userProfile.profilePicture),
            InkWell(
              onTap: onPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  !isAnswer
                      ? Text(
                          question.title,
                          style: textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: 1.h,
                  ),
                  isFormattedBody
                      ? QuillEditor.basic(
                          controller: QuillController(
                            document: Document.fromJson(
                                json.decode(question.description)),
                            selection: const TextSelection.collapsed(
                                offset: -1, affinity: TextAffinity.upstream),
                          ),
                          readOnly: true,
                        )
                      : ExpandableText(
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
                          fit: BoxFit.cover,
                          imageURL: question.imageUrl,
                          width: double.infinity,
                          height: 35.h,
                          borderRadius: 4,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            showDivider
                ? const Divider(
                    color: white,
                    thickness: 2,
                  )
                : const SizedBox(),
            showActions
          ],
        ));
  }
}
