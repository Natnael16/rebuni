part of 'get_questions_bloc.dart';

abstract class GetQuestionsEvent extends Equatable {
  const GetQuestionsEvent();

  @override
  List<Object> get props => [];
}

class GetQuestions extends GetQuestionsEvent{}