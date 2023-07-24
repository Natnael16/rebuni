import '../../domain/entity/vote.dart';

class VoteModel extends Vote {
  VoteModel({
    required String voteId,
    required DateTime createdAt,
    required int upvote,
    required int downvote,
  }) : super(
          voteId: voteId,
          createdAt: createdAt,
          upvote: upvote,
          downvote: downvote,
        );

  factory VoteModel.fromJson(Map<String, dynamic> json) {
    return VoteModel(
      voteId: json['voteId'],
      createdAt: DateTime.parse(json['createdAt']),
      upvote: json['upvote'],
      downvote: json['downvote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voteId': voteId,
      'createdAt': createdAt.toIso8601String(),
      'upvote': upvote,
      'downvote': downvote,
    };
  }
}
