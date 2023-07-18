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
}
