import '../../domain/entity/discussion.dart';
import '../../domain/entity/user_profile.dart';
import 'vote_model.dart';

class DiscussionModel extends Discussion {
  const DiscussionModel({
    required String discussionId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String description,
    required VoteModel vote,
    required UserProfile userProfile,
    required String replyId,
    required int numberOfReplies,
    required String postId,
    required String questionId,
    required int userReaction,
  }) : super(
            discussionId: discussionId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            description: description,
            vote: vote,
            userProfile: userProfile,
            replyId: replyId,
            numberOfReplies: numberOfReplies,
            postId: postId,
            questionId: questionId,
            userReaction: userReaction);

  factory DiscussionModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return DiscussionModel(
        questionId: json['question_id'] ?? '',
        discussionId: json['discussion_id'] ?? '',
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        description: json['body'] ?? '',
        vote: VoteModel.fromJson(json['vote']),
        userProfile: json['user_profile'],
        replyId: json['reply_id'] ?? "",
        numberOfReplies: json['number_of_replies'] as int,
        postId: json['post_id'] ?? "",
        userReaction: json['user_reaction']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'discussionId': discussionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'body': description,
      'vote': vote.toJson(),
      'userId': userProfile,
      'replyId': replyId,
      'numberOfReplies': numberOfReplies,
      'postId': postId,
    };
  }
}
