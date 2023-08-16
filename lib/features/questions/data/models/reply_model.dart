import '../../domain/entity/reply.dart';
import '../../domain/entity/user_profile.dart';
import 'vote_model.dart';

class ReplyModel extends Reply {

  const ReplyModel({
    required String discussionId,
    required String answerId,
    required String replyId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String description,
    required VoteModel vote,
    required UserProfile userProfile,
    required int userReaction,
  }) : super(

          answerId : answerId,
          discussionId: discussionId,
          replyId: replyId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          description: description,
          vote: vote,
          userProfile: userProfile,
          userReaction: userReaction
        );

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      answerId: json["answer_id"].toString(),
      discussionId: json['discussion_id'] ?? '',
      replyId: json['reply_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      description: json['body'],
      vote: VoteModel.fromJson(json['vote']),
      userProfile: json['user_profile'],
      userReaction: json['user_reaction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discussionId': discussionId,
      'answerId' : answerId,
      'replyId': replyId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'vote': vote.toJson(),
      'userProfile': userProfile.toJson(),
    };
  }

}
