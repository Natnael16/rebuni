import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/question.dart';
import '../repository/questions_repository.dart';

class GetBookmarksUseCase implements UseCase<List<Question>, NoParams> {
  final QuestionsRepository questionsRepository;

  GetBookmarksUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, List<Question>>> call(NoParams noParams) async {
    final Either<Failure, List<Question>> getBookmarksResult =
        await questionsRepository.getBookmarks();
    return getBookmarksResult;
  }
}
