import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/questions_repository.dart';

class PostQuestionUseCase implements UseCase<bool, PostAnswerParams> {
  final QuestionsRepository questionsRepository;

  PostQuestionUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, bool>> call(PostAnswerParams params) async {
    final String title = params.title;
    final String description = params.description;
    final File? image = params.image;
    final List<String> categories = params.categories;
    final bool isAnonymous = params.isAnonymous;
    // Sign in the user
    final Either<Failure, bool> signUpResult =
        await questionsRepository.postQuestion(
            title: title,
            description: description,
            image: image,
            categories: categories,
            isAnonymous : isAnonymous);
    return signUpResult;
  }
}

class PostAnswerParams {
  final String title;
  final String description;
  final File? image;
  final List<String> categories;
  final bool isAnonymous;

  PostAnswerParams(
      {required this.title,
      required this.description,
      this.image,
      required this.categories,
      required this.isAnonymous});
}
