part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class PostQuestion extends QuestionsEvent {
  final String title;
  final String description;
  final File? image;
  final List<String> categories;
  final bool isAnonymous;

  PostQuestion(
      {required this.title,
      required this.description,
      this.image,
      required this.categories,
      required this.isAnonymous});
}
