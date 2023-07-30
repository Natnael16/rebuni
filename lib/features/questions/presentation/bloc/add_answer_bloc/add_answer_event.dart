part of 'add_answer_bloc.dart';

abstract class AddAnswerEvent extends Equatable {
  const AddAnswerEvent();

  @override
  List<Object> get props => [];
}

class AddAnswer extends AddAnswerEvent {
  final String questionId;
  final String description;
  final File? image;

  AddAnswer(
    {
    required this.questionId,
    required this.description,
    this.image,
  });
  @override
  List<Object> get props => [description, questionId];
}
