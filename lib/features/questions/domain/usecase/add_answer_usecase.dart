import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/questions_repository.dart';

class PostAnswerUseCase implements UseCase<bool, PostAnswerParams> {
  final QuestionsRepository AnswersRepository;

  PostAnswerUseCase(this.AnswersRepository);

  @override
  Future<Either<Failure, bool>> call(PostAnswerParams params) async {
    final String description = params.description;
    final File? image = params.image;
    final String id =  params.questionId;

    // Sign in the user
    final Either<Failure, bool> signUpResult =
        await AnswersRepository.postAnswer(
          questionId : id,
            description: description,
            image: image,
            );

    return signUpResult;
  }
}

class PostAnswerParams {
 String questionId;
  final String description;
  final File? image;

  PostAnswerParams(
      {
        required this.questionId,
      required this.description,
      this.image,
 });
}
