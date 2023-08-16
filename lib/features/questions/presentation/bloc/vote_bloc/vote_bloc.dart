import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rebuni/features/questions/domain/usecase/vote_usecase.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entity/vote_type.dart';

part 'vote_event.dart';
part 'vote_state.dart';

const throttleDuration = Duration(seconds: 1);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  int initUpvoteCount;
  int initDownvoteCount;
  VoteType initCurrentVote;
  VoteType initPreviousVote;
  VoteUseCase addVote;
  @override
  Future<void> close() async {
  }

  VoteBloc(this.addVote,
      {required this.initUpvoteCount,
      required this.initDownvoteCount,
      required this.initCurrentVote,
      required this.initPreviousVote})
      : super(VoteState(
            upvoteCount: initUpvoteCount,
            downvoteCount: initDownvoteCount,
            currentVote: initCurrentVote,
            previousVote: initPreviousVote,
            voteState: EVoteState.initial)) {
    on<LikeDislike>(
      _onLikeDislike,
      transformer: throttleDroppable(throttleDuration),
    );
    on<SetInitialVote>(_onSetInitialVote);
  }
  _onLikeDislike(LikeDislike event, Emitter emit) async {
    VoteState prevState = VoteState(
      currentVote: state.currentVote,
      previousVote: state.previousVote,
      upvoteCount: state.upvoteCount,
      downvoteCount: state.downvoteCount,
      voteState: state.voteState,
    );

    VoteType currentVote = state.currentVote;
    VoteType previousVote = currentVote;

    int likeCount = state.upvoteCount;
    int dislikeCount = state.downvoteCount;

    if (event.voteType) {
      if (currentVote == VoteType.Like) likeCount--;
      if (currentVote == VoteType.Dislike) dislikeCount--;
      currentVote =
          currentVote == VoteType.Like ? VoteType.None : VoteType.Like;
      likeCount = currentVote == VoteType.Like ? likeCount + 1 : likeCount;
    } else {
      if (currentVote == VoteType.Dislike) dislikeCount--;
      if (currentVote == VoteType.Like) likeCount--;
      currentVote =
          currentVote == VoteType.Dislike ? VoteType.None : VoteType.Dislike;
      dislikeCount =
          currentVote == VoteType.Dislike ? dislikeCount + 1 : dislikeCount;
    }

    VoteState nextState = VoteState(
      currentVote: currentVote,
      previousVote: previousVote,
      upvoteCount: likeCount,
      downvoteCount: dislikeCount,
      voteState: EVoteState.loading,
    );

    emit(nextState);

    Either<Failure, bool> response = await addVote(VoteParams(
      id: event.id,
      table: event.table,
      voteType: event.voteType,
    ));

    response.fold(
        (Failure failure) => emit(VoteState(
              currentVote: prevState.currentVote,
              previousVote: prevState.previousVote,
              upvoteCount: prevState.upvoteCount,
              downvoteCount: prevState.downvoteCount,
              voteState: EVoteState.failed,
            )), (bool success) {
      nextState.voteState = EVoteState.success;
      emit(nextState);
    });
  }

  _onSetInitialVote(SetInitialVote event, Emitter emit) {
    emit(VoteState(
        currentVote: event.currentVote,
        previousVote: event.previousVote,
        upvoteCount: event.upvoteCount,
        downvoteCount: event.downvoteCount,
        voteState: event.voteState));
  }
}
