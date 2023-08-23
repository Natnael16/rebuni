part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkSuccess extends BookmarkState {
  final List<Question> questions;

  const BookmarkSuccess(this.questions);
}

class BookmarkFailure extends BookmarkState {
  final String errorMessage;

  const BookmarkFailure(this.errorMessage);
   @override
  List<Object> get props => [errorMessage];

}
