import '../../domain/entity/question.dart';
import '../../domain/entity/user_profile.dart';
import 'answer_model.dart';
import 'discusion_model.dart';
import 'user_profile_model.dart';
import 'vote_model.dart';

class QuestionModel extends Question {
  QuestionModel({
    required String questionId,
    required DateTime createdAt,
    required String title,
    required String description,
    required String imageUrl,
    required DateTime updatedAt,
    required bool isClosed,
    required VoteModel vote,
    required int numberOfViews,
    required int numberOfAnswers,
    required UserProfile userProfile,
    required int numberOfDiscussions,
    required bool isAnonymous,
    required List<String> categories,
  
  }) : super(
          questionId: questionId,
          createdAt: createdAt,
          title: title,
          description: description,
          imageUrl: imageUrl,
          updatedAt: updatedAt,
          isClosed: isClosed,
          vote: vote,
          numberOfViews: numberOfViews,
          numberOfAnswers: numberOfAnswers,
          userProfile: userProfile,
          numberOfDiscussions: numberOfDiscussions,
          isAnonymous: isAnonymous,
          categories : categories
        );

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      categories : json['categories'],
      questionId: json['questionId'],
      createdAt: DateTime.parse(json['createdAt']),
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      updatedAt: DateTime.parse(json['updatedAt']),
      isClosed: json['isClosed'],
      vote: VoteModel.fromJson(json['vote']),
      numberOfViews: json['numberOfViews'],
      numberOfAnswers: json['numberOfAnswers'],
          
      userProfile: UserProfile.fromJson(json['userProfile']),
      numberOfDiscussions: json['numberOfDiscussions'],
      isAnonymous: json['isAnonymous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'updated_At': updatedAt.toIso8601String(),
      'is_closed': isClosed,
      'vote': vote.toJson(),
      'number_of_views': numberOfViews,
      'number_of_answers': numberOfAnswers,
      'user_profile': userProfile.toJson(),
      'number_of_discussions': numberOfDiscussions,
      'is_anonymous': isAnonymous,
      'categories' : categories
    };
  }
}
