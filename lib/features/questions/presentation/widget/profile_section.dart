import 'package:flutter/material.dart';
import 'package:rebuni/features/questions/presentation/widget/custom_cached_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/colors.dart';
import '../../domain/entity/question.dart';


import 'default_profile_image.dart';


Widget profileSection(TextTheme textTheme,Question question) {
  return Row(
    children: [
      CircleAvatar(
        minRadius: 2.5.h,
        maxRadius: 2.5.h,
        child:question.userProfile.profilePicture != '' && !question.isAnonymous ? CustomizedCachedImage(imageURL: question.userProfile.profilePicture ,borderRadius: 50,fit: BoxFit.cover) : DefaultProfileImage(name: question.userProfile.fullName)
      ),
      SizedBox(width: 2.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                question.isAnonymous ? "Anonymous" : question.userProfile.fullName,
                style: textTheme.bodyMedium,
              ),
              SizedBox(width: 1.w),
              Icon(Icons.verified_outlined, color: answeredYellow, size: 2.h)
            ],
          ),
          Text(
            buildTimestampText(question.createdAt),
            style: textTheme.labelSmall!.copyWith(fontSize: 13.sp),
          ),
        ],
      ),
      const Spacer(),
      const Icon(Icons.more_horiz)
    ],
  );
}

String buildTimestampText(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  // Check if the difference is less than an hour
  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} mins ago';
  }

  // Check if the difference is less than a day
  if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  }

  // Format as a specific time if older than a day
  final formatter = DateFormat('hh:mm a');
  return formatter.format(dateTime);
}
