import 'package:equatable/equatable.dart';

import 'user_profile.dart';
import 'vote.dart';

class Reply extends Equatable {
  final String replyId;
  final String answerId;
  final String discussionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;
  final Vote vote;
  final UserProfile userProfile;

  Reply({
    required this.answerId,
    required this.discussionId,
    required this.replyId,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.vote,
    required this.userProfile,
  });

  @override
  List<Object?> get props => [replyId, description];
}
