import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecase/add_delete_bookmark_usecase.dart';

part 'add_bookmark_event.dart';
part 'add_bookmark_state.dart';

class AddBookmarkBloc extends Bloc<AddBookmarkEvent, AddBookmarkState> {

  @override
  Future<void> close() async{
  }
  AddBookmarksUseCase addBookmarkUseCase;
  final bool initBookmarkState;
  AddBookmarkBloc(this.addBookmarkUseCase, this.initBookmarkState)
      : super(AddBookmarkInitial(initBookmarkState)) {
    on<BookmarkPressed>(_onBookmarkPressed);
  }
  _onBookmarkPressed(BookmarkPressed event, Emitter emit) async {
    emit(AddBookmarkLoading(!state.curVoteType));
    var response = await addBookmarkUseCase(event.questionId);
    response.fold(
        (Failure failure) => emit(AddBookmarkFailure(!state.curVoteType)),
        (bool success) => emit(AddBookmarkSuccess(state.curVoteType)));
  }
}
