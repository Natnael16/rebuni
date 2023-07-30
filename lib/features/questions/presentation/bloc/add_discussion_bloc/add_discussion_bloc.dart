import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecase/add_discussion_or_reply.dart';

part 'add_discussion_event.dart';
part 'add_discussion_state.dart';

class AddDiscussionBloc extends Bloc<AddDiscussionEvent, AddDiscussionState> {
  AddDiscussionUseCase addDiscussion;

  AddDiscussionBloc(this.addDiscussion) : super(AddDiscussionInitial()) {
    on<AddDiscussion>(_onAddDiscussion);
  }
  _onAddDiscussion(
      AddDiscussion event, Emitter<AddDiscussionState> emit) async {
    emit(AddDiscussionLoading());
    var response = await addDiscussion(AddReplyParams(
        id: event.id, body: event.body, isQuestion: event.isQuestion));
    response.fold(
        (Failure failure) => emit(AddDiscussionFailure(failure.errorMessage)),
        (bool success) => emit(AddDiscussionSuccess()));
  }
}
