import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entity/question.dart';
import '../../../domain/usecase/fetch_bookmarks_usecase.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  GetBookmarksUseCase getBookmarksUseCase;
  BookmarkBloc(this.getBookmarksUseCase) : super(BookmarkInitial()) {
    on<BookmarkFetch>(_onBookmarkFetch);
  }

  _onBookmarkFetch(BookmarkFetch event, Emitter<BookmarkState> emit) async {
    emit(BookmarkLoading());
    var response = await getBookmarksUseCase(NoParams());
    response.fold(
        (Failure failure) => emit(BookmarkFailure(failure.errorMessage)),
        (List<Question> success) => emit(BookmarkSuccess(success)));
  }
}
