import 'user_profile.dart';
import 'vote.dart';

class Answer {
  final int answerId;
  final DateTime createdAt;
  final UserProfile userProfile;
  final DateTime updatedAt;
  final String description;
  final Vote vote;
  final String imageUrl;
  final String questionId;
  final bool isAnsweredForUser;
  final int numberOfReplies;
  final int userReaction;

  Answer(
      {required this.answerId,
      required this.createdAt,
      required this.userProfile,
      required this.updatedAt,
      required this.description,
      required this.vote,
      required this.imageUrl,
      required this.questionId,
      required this.isAnsweredForUser,
      required this.numberOfReplies,
      required this.userReaction});

  Map<String, dynamic> toJson() {
    return {
      'answerId': answerId,
      'createdAt': createdAt.toIso8601String(),
      'userId': userProfile,
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'vote': vote.toJson(),
      'imageUrl': imageUrl,
      'questionId': questionId,
      'isAnsweredForUser': isAnsweredForUser,
    };
  }
}
