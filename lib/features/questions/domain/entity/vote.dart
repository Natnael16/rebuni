class Vote {
  final String voteId;
  final DateTime createdAt;
  final int upvote;
  final int downvote;

  Vote({
    required this.voteId,
    required this.createdAt,
    required this.upvote,
    required this.downvote,
  });

  Map<String, dynamic> toJson() {
    return {
      'voteId': voteId,
      'createdAt': createdAt.toIso8601String(),
      'upvote': upvote,
      'downvote': downvote,
    };
  }
}
