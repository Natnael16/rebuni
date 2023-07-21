import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/question.dart';
import '../repository/questions_repository.dart';

class GetQuestionsUseCase implements UseCase<List<Question>, int> {
  final QuestionsRepository questionsRepository;

  GetQuestionsUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, List<Question>>> call(int startIndex) async {
    
    final Either<Failure, List<Question>> getQuestionsResult =
        await questionsRepository.getQuestions(startIndex);
    return getQuestionsResult;
  }
}
