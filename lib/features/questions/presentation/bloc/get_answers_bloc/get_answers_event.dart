part of 'get_answers_bloc.dart';

abstract class GetAnswersEvent extends Equatable {
  const GetAnswersEvent();

  @override
  List<Object> get props => [];
}

class GetAnswers extends GetAnswersEvent {
  final String questionId;

  const GetAnswers(this.questionId);
}
