class UserProfile {
  final int userProfileId;
  final DateTime createdAt;
  final String userId;
  final String bio;
  final String profilePicture;
  final String fullName;
  final String followers;
  final String following;

  UserProfile({
    required this.userProfileId,
    required this.createdAt,
    required this.userId,
    required this.bio,
    required this.profilePicture,
    required this.fullName,
    required this.followers,
    required this.following,
  });
}
