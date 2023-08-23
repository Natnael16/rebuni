import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/questions_repository.dart';

class AddBookmarksUseCase implements UseCase<bool, String> {
  final QuestionsRepository questionsRepository;

  AddBookmarksUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, bool>> call(String id) async {
    final Either<Failure, bool> addBookmarksResult =
        await questionsRepository.addBookmark(id);
    return addBookmarksResult;
  }
}
