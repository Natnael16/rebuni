part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

class LikeEvent extends VoteEvent {

}


class LikeDislike extends VoteEvent {
  final String id;
  final bool voteType;
  final String table;

  const LikeDislike(
      {required this.id, required this.voteType, required this.table});

  @override
  List<Object> get props => [id,table,voteType];
}

class SetInitialVote extends VoteEvent {
  EVoteState voteState;
  final int upvoteCount;
  final int downvoteCount;
  final VoteType currentVote;
  final VoteType previousVote;
  SetInitialVote({
    required this.voteState,
    required this.upvoteCount,
    required this.downvoteCount,
    required this.currentVote,
    required this.previousVote,
  });
}
