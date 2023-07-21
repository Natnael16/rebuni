
import '../../domain/entity/discussion.dart';
import 'answer_model.dart';
import 'vote_model.dart';

class DiscussionModel extends Discussion {
  DiscussionModel({
    required String discussionId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String body,
    required VoteModel vote,
    required String userId,
    required String replyId,
    required int numberOfReplies,
    required AnswerModel answer,
    required String postId,
  }) : super(
          discussionId: discussionId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          body: body,
          vote: vote,
          userId: userId,
          replyId: replyId,
          numberOfReplies: numberOfReplies,
          answer: answer,
          postId: postId,
        );

  factory DiscussionModel.fromJson(Map<String, dynamic> json) {
    return DiscussionModel(
      discussionId: json['discussionId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      body: json['body'],
      vote: VoteModel.fromJson(json['vote']),
      userId: json['userId'],
      replyId: json['replyId'],
      numberOfReplies: json['numberOfReplies'],
      answer: AnswerModel.fromJson(json['answer']),
      postId: json['postId'],
    );
  }

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
