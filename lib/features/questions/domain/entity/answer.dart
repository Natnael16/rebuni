import 'vote.dart';

class Answer {
  final int answerId;
  final DateTime createdAt;
  final String userId;
  final DateTime updatedAt;
  final String description;
  final Vote vote;
  final String imageUrl;
  final String questionId;
  final bool isAnsweredForUser;

  Answer({
    required this.answerId,
    required this.createdAt,
    required this.userId,
    required this.updatedAt,
    required this.description,
    required this.vote,
    required this.imageUrl,
    required this.questionId,
    required this.isAnsweredForUser,
  });

   Map<String, dynamic> toJson() {
    return {
      'answerId': answerId,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'vote': vote.toJson(),
      'imageUrl': imageUrl,
      'questionId': questionId,
      'isAnsweredForUser': isAnsweredForUser,
    };
  }
}
