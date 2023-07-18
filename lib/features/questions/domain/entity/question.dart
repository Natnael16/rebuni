import 'answer.dart';
import 'discussion.dart';
import 'user_profile.dart';
import 'vote.dart';

class Question {
  final String questionId;
  final DateTime createdAt;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime updatedAt;
  final bool isClosed;
  final Vote vote;
  final int numberOfViews;
  final List<Answer> answers;
  final UserProfile userProfile;
  final List<Discussion> discussions;
  final bool isAnonymous;

  Question({
    required this.questionId,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.updatedAt,
    required this.isClosed,
    required this.vote,
    required this.numberOfViews,
    required this.answers,
    required this.userProfile,
    required this.discussions,
    required this.isAnonymous,
  });
}
