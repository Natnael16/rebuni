part of 'add_discussion_bloc.dart';

abstract class AddDiscussionState extends Equatable {
  const AddDiscussionState();

  @override
  List<Object> get props => [];
}

class AddDiscussionInitial extends AddDiscussionState {}

class AddDiscussionLoading extends AddDiscussionState {}

class AddDiscussionSuccess extends AddDiscussionState {}

class AddDiscussionFailure extends AddDiscussionState {
  final String errorMessage;

  AddDiscussionFailure(this.errorMessage);
}
