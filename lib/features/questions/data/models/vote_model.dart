import '../../domain/entity/vote.dart';

class VoteModel extends Vote {
  VoteModel({
    required int upvote,
    required int downvote,
  }) : super(
          upvote: upvote,
          downvote: downvote,
        );

  factory VoteModel.fromJson(Map<String, dynamic> json) {
    return VoteModel(
      upvote: json['upvote'],
      downvote: json['downvote'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'upvote': upvote,
      'downvote': downvote,
    };
  }
}
