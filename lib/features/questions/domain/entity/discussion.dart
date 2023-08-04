import 'package:equatable/equatable.dart';

import 'user_profile.dart';
import 'vote.dart';

class Discussion extends Equatable {
  final String discussionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;
  final Vote vote;
  final UserProfile userProfile;
  final String replyId;
  final int numberOfReplies;
  final String questionId;
  final String postId;

  const Discussion({
    required this.discussionId,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.vote,
    required this.userProfile,
    required this.replyId,
    required this.numberOfReplies,
    required this.postId,
    required this.questionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'discussionId': discussionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'body': description,
      'vote': vote.toJson(),
      'userProfile': userProfile,
      'replyId': replyId,
      'numberOfReplies': numberOfReplies,
      'postId': postId,
      'questionId': questionId
    };
  }

  @override
  List<Object?> get props => [
        discussionId,
        createdAt,
        updatedAt,
        description,
        vote,
        userProfile,
        replyId,
        numberOfReplies,
        postId,
        questionId
      ];
}
