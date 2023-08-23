import '../../domain/entity/question.dart';
import '../../domain/entity/user_profile.dart';
import 'vote_model.dart';

class QuestionModel extends Question {
  const QuestionModel({
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
    required int userReaction,
    required bool userBookmarked
  
  }) : super(
          userBookmarked: userBookmarked,
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
          categories : categories,
          userReaction : userReaction
        );

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      userBookmarked: json['user_bookmarked'],
      categories : (json['categories'] as List<dynamic>).map((elem) => elem as String).toList(),
      questionId: json['question_id'],
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      updatedAt: DateTime.parse(json['updated_at']),
      isClosed: json['is_closed'],
      vote: VoteModel.fromJson(json['vote']),
      numberOfViews: json['number_of_views'],
      numberOfAnswers: json['number_of_answers'],
      userReaction: json['user_reaction'],
      userProfile: json['user_profile'].runtimeType == UserProfile?json['user_profile'] : UserProfile.fromJson(json['user_profile']) ,
      numberOfDiscussions: json['number_of_discussions'],
      isAnonymous: json['is_anonymous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_bookmarked': userBookmarked,
      'categories': List<dynamic>.from(categories.map((elem) => elem)),
      'question_id': questionId,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
      'is_closed': isClosed,
      'vote': vote.toJson(),
      'number_of_views': numberOfViews,
      'number_of_answers': numberOfAnswers,
      'user_reaction': userReaction,
      'user_profile': userProfile.toJson(),
      'number_of_discussions': numberOfDiscussions,
      'is_anonymous': isAnonymous,
    };
  }
}
