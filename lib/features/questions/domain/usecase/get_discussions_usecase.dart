import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/discussion.dart';
import '../repository/questions_repository.dart';

class GetDiscussionsUseCase implements UseCase<List<Discussion>, String> {
  final QuestionsRepository questionsRepository;

  GetDiscussionsUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, List<Discussion>>> call(String questionId) async {
    final Either<Failure, List<Discussion>> getDiscussionsResult =
        await questionsRepository.getDiscussions(questionId);
    return getDiscussionsResult;
  }
}
