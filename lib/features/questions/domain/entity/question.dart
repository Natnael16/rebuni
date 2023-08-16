import 'package:equatable/equatable.dart';

import 'user_profile.dart';
import 'vote.dart';

class Question extends Equatable {
  final String questionId;
  final DateTime createdAt;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime updatedAt;
  final bool isClosed;
  final Vote vote;
  final int numberOfViews;
  final int numberOfAnswers;
  final UserProfile userProfile;
  final int numberOfDiscussions;
  final bool isAnonymous;
  final List<String> categories;
  final int userReaction;

  const Question(
      {required this.questionId,
      required this.createdAt,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.updatedAt,
      required this.isClosed,
      required this.vote,
      required this.numberOfViews,
      required this.numberOfAnswers,
      required this.userProfile,
      required this.numberOfDiscussions,
      required this.isAnonymous,
      required this.categories,
      required this.userReaction
      });

  @override
  List<Object?> get props => [
        questionId,
        title,
      ];
}
