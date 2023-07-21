import '../../domain/entity/answer.dart';
import 'vote_model.dart';

class AnswerModel extends Answer {
  AnswerModel({
    required super.answerId,
    required super.createdAt,
    required super.userId,
    required super.updatedAt,
    required super.description,
    required super.vote,
    required super.imageUrl,
    required super.questionId,
    required super.isAnsweredForUser,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      answerId: json['answerId'],
      createdAt: DateTime.parse(json['createdAt']),
      userId: json['userId'],
      updatedAt: DateTime.parse(json['updatedAt']),
      description: json['description'],
      vote: VoteModel.fromJson(json['vote']),
      imageUrl: json['imageUrl'],
      questionId: json['questionId'],
      isAnsweredForUser: json['isAnsweredForUser'],
    );
  }
  
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
