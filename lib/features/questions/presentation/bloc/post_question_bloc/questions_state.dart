part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class PostQuestionLoading extends QuestionsState {}

class PostQuestionSuccess extends QuestionsState {}

class PostQuestionFailure extends QuestionsState {
  final String errorMessage;

  const PostQuestionFailure(this.errorMessage);
}
