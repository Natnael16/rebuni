part of 'add_answer_bloc.dart';

abstract class AddAnswerState extends Equatable {
  const AddAnswerState();
  
  @override
  List<Object> get props => [];
}

class AddAnswerInitial extends AddAnswerState {}


class AddAnswerLoading extends AddAnswerState {}

class AddAnswerSuccess extends AddAnswerState {}

class AddAnswerFailure extends AddAnswerState {
  final String errorMessage;

  AddAnswerFailure(this.errorMessage);
}
