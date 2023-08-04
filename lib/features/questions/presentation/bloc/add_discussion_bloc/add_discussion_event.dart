part of 'add_discussion_bloc.dart';

abstract class AddDiscussionEvent extends Equatable {
  const AddDiscussionEvent();

  @override
  List<Object> get props => [];
}

class AddDiscussion extends AddDiscussionEvent {
  final String id;
  final bool isQuestion;
  final String body;

  const AddDiscussion({required this.id, this.isQuestion = true, required this.body});
}

