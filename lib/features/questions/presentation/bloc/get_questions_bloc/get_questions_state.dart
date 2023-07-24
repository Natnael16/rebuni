part of 'get_questions_bloc.dart';

abstract class GetQuestionsState extends Equatable {
  const GetQuestionsState();
  
  @override
  List<Object> get props => [];
}

class GetQuestionsInitial extends GetQuestionsState {}




class QuestionsLoaded extends GetQuestionsState{
  final List<Question> questions;
  final bool hasReachedMax;

  @override
  List<Object> get props => [questions, hasReachedMax];

  const QuestionsLoaded(this.questions,[this.hasReachedMax = false]);
}

class GetQuestionsFailure extends GetQuestionsState{

  final String errorMessage;

  const GetQuestionsFailure(this.errorMessage);
}

class GetQuestionsLoading extends GetQuestionsState{}