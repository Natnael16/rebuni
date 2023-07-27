part of 'get_answers_bloc.dart';

abstract class GetAnswersState extends Equatable {
  const GetAnswersState();

  @override
  List<Object> get props => [];
}

class GetAnswersInitial extends GetAnswersState {}

class GetAnswersLoading extends GetAnswersState {}

class GetAnswersSuccess extends GetAnswersState {
  final List<Answer> answerList;

  GetAnswersSuccess(this.answerList);
}

class GetAnswersFailure extends GetAnswersState {
  final String errorMessage;

  GetAnswersFailure(this.errorMessage);
}
