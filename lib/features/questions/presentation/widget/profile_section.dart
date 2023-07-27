import 'package:flutter/material.dart';
import 'package:rebuni/features/questions/presentation/widget/custom_cached_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/colors.dart';
import 'default_profile_image.dart';

Widget profileSection(
  TextTheme textTheme, {
  required String fullName,
  String profilePicture = '',
  bool isAnonymous = false,
  required DateTime createdAt,
  void Function()? onPressed,
}) {
  return Row(
    children: [
      CircleAvatar(
        minRadius: 2.5.h,
        maxRadius: 2.5.h,
        child: profilePicture != '' && !isAnonymous
            ? CustomizedCachedImage(
                imageURL: profilePicture,
                borderRadius: 50,
                fit: BoxFit.cover,
              )
            : DefaultProfileImage(name: fullName),
      ),
      SizedBox(width: 2.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isAnonymous ? "Anonymous" : fullName,
                style: textTheme.bodyMedium,
              ),
              SizedBox(width: 1.w),
              Icon(Icons.verified_outlined, color: answeredYellow, size: 2.h),
            ],
          ),
          Text(
            buildTimestampText(createdAt),
            style: textTheme.labelSmall!.copyWith(fontSize: 13.sp),
          ),
        ],
      ),
      const Spacer(),
      InkWell( onTap: onPressed,child:  const Icon(Icons.more_horiz)),
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
  final formatter = DateFormat('MMM d, yyyy, hh:mm a');
  return formatter.format(dateTime);
}
