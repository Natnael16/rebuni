part of 'add_bookmark_bloc.dart';

abstract class AddBookmarkState extends Equatable {
  final bool curVoteType;

  const AddBookmarkState(this.curVoteType);

  @override
  List<Object> get props => [curVoteType];
}

class AddBookmarkInitial extends AddBookmarkState {
  const AddBookmarkInitial(bool curVoteType) : super(curVoteType);
}

class AddBookmarkLoading extends AddBookmarkState {
  const AddBookmarkLoading(bool curVoteType) : super(curVoteType);
}

class AddBookmarkSuccess extends AddBookmarkState {
  const AddBookmarkSuccess(bool curVoteType) : super(curVoteType);
}

class AddBookmarkFailure extends AddBookmarkState {
  const AddBookmarkFailure(bool curVoteType) : super(curVoteType);
}
