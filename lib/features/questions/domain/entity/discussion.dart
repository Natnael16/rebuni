import 'answer.dart';
import 'vote.dart';

class Discussion {
  final String discussionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String body;
  final Vote vote;
  final String userId;
  final String replyId;
  final int numberOfReplies;
  final Answer answer;
  final String postId;

  Discussion({
    required this.discussionId,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.vote,
    required this.userId,
    required this.replyId,
    required this.numberOfReplies,
    required this.answer,
    required this.postId,
  });

  Map<String, dynamic> toJson() {
    return {
      'discussionId': discussionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'body': body,
      'vote': vote.toJson(),
      'userId': userId,
      'replyId': replyId,
      'numberOfReplies': numberOfReplies,
      'answer': answer.toJson(),
      'postId': postId,
    };
  }
}
