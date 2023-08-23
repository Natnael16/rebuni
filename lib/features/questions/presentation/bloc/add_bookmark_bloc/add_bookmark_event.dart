part of 'add_bookmark_bloc.dart';

abstract class AddBookmarkEvent extends Equatable {
  const AddBookmarkEvent();

  @override
  List<Object> get props => [];
}

class BookmarkPressed extends AddBookmarkEvent {
  final String questionId;

  const BookmarkPressed(this.questionId);

}
