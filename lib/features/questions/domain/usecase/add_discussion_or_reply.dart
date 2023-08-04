
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/questions_repository.dart';

class AddDiscussionUseCase implements UseCase<bool, AddReplyParams> {
  final QuestionsRepository questionsRepository;

  AddDiscussionUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, bool>> call(AddReplyParams params) async {
    final String id = params.id;
    final String body = params.body;
    final bool isAnswer = params.isQuestion;
    // Sign in the user
    final Either<Failure, bool> signUpResult =
        await questionsRepository.addReply(
      id: id,
      body: body,
      isQuestion: isAnswer,
    );
    return signUpResult;
  }
}

class AddReplyParams {
  final String id;
  final String body;
  final bool isQuestion;

  AddReplyParams(
      {required this.id, required this.body, required this.isQuestion});
}
