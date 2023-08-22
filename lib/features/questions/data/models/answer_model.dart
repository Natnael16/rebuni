import '../../domain/entity/answer.dart';
import 'vote_model.dart';

class AnswerModel extends Answer {
  AnswerModel({
    required super.numberOfReplies,
    required super.answerId,
    required super.createdAt,
    required super.userProfile,
    required super.updatedAt,
    required super.description,
    required super.vote,
    required super.imageUrl,
    required super.questionId,
    required super.isAnsweredForUser,
    required super.userReaction
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {

    return AnswerModel(
      userReaction : json['user_reaction'] ?? 0,
      numberOfReplies: json['number_of_replies'] ?? 0,
      answerId: json['answer_id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      userProfile: json['user_profile'],
      updatedAt: DateTime.parse(json['updated_at']),
      description: json['description'] ?? '',
      vote: VoteModel.fromJson(json['vote']),
      imageUrl: json['image_url'] ?? '',
      questionId: json['question_id'],
      isAnsweredForUser: json['is_answered_for_user'],
    );
  }

  @override
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
      "number_of_replies": numberOfReplies
    };
  }
}
