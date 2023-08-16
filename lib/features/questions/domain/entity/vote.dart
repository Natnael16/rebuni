class Vote {

  final int upvote;
  final int downvote;

  Vote({

    required this.upvote,
    required this.downvote,
  });

  Map<String, dynamic> toJson() {
    return {
      'upvote': upvote,
      'downvote': downvote,
    };
  }
}
