import '../../domain/entity/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.userProfileId,
    required super.createdAt,
    required super.userId,
    required super.bio,
    required super.profilePicture,
    required super.followers,
    required super.followings,
    required super.fullName,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> userProfileData) {
    return UserProfileModel(
      userId: userProfileData['user_id'],
      userProfileId: userProfileData['user_profile_id'] as int,
      fullName: userProfileData['full_name'] as String,
      createdAt: DateTime.parse(userProfileData['created_at'] as String),
      profilePicture: userProfileData['profile_picture'] ?? '',
      bio: userProfileData['bio'] as String,
      followers: (userProfileData['followers'] as List<dynamic>)
          .map((id) => id as String)
          .toList(),
      followings: (userProfileData['followings'] as List<dynamic>)
          .map((id) => id as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userProfileId': userProfileId,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'bio': bio,
      'profilePicture': profilePicture,
      'fullName': fullName,
      'followers': followers,
      'followings': followings,
    };
  }
}
