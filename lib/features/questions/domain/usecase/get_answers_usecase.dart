import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/answer.dart';
import '../repository/questions_repository.dart';

class GetAnswersUseCase implements UseCase<List<Answer>, String> {
  final QuestionsRepository answersRepository;

  GetAnswersUseCase(this.answersRepository);

  @override
  Future<Either<Failure, List<Answer>>> call(String questionId) async {
    final Either<Failure, List<Answer>> getAnswersResult =
        await answersRepository.getAnswers(questionId);
    return getAnswersResult;
  }
}
