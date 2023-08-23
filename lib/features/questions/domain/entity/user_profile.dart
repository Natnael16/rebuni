import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final int userProfileId;
  final DateTime createdAt;
  final String userId;
  final String bio;
  final String profilePicture;
  final String fullName;
  final List<String> followers;
  final List<String> followings;

  const UserProfile({
    required this.userProfileId,
    required this.createdAt,
    required this.userId,
    required this.bio,
    required this.profilePicture,
    required this.fullName,
    required this.followers,
    required this.followings,
  });

  factory UserProfile.fromJson(Map<String, dynamic> userProfileData) {
    var userprofile = UserProfile(
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
    return userprofile;
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_profile_id': userProfileId,
      'full_name': fullName,
      'created_at': createdAt.toIso8601String(),
      'profile_picture': profilePicture,
      'bio': bio,
      'followers': followers,
      'followings': followings,
    };
  }
  
  @override
  List<Object?> get props => [userProfileId, createdAt, userId, bio, profilePicture, fullName,followers,followings];
}
