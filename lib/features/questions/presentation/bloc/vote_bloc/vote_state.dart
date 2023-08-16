part of 'vote_bloc.dart';



enum EVoteState {
  initial,
  loading,
  success,
  failed,
}

class VoteState extends Equatable {
  EVoteState voteState;
  final int upvoteCount;
  final int downvoteCount;
  final VoteType currentVote;
  final VoteType previousVote;
    VoteState({
    required this.voteState,
    required this.upvoteCount,
    required this.downvoteCount,
    required this.currentVote,
    required this.previousVote,
  });

  @override
  List<Object> get props =>
      [voteState, upvoteCount, downvoteCount, currentVote, previousVote];
}
