import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/reply.dart';
import '../repository/questions_repository.dart';

class GetRepliesUseCase implements UseCase<List<Reply>, RepliesParams> {
  final QuestionsRepository questionsRepository;

  GetRepliesUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, List<Reply>>> call(RepliesParams repliesParams) async {
    final Either<Failure, List<Reply>> getReplysResult =
        await questionsRepository.getReplies(
            repliesParams.id, repliesParams.isAnswer);
    return getReplysResult;
  }
}

class RepliesParams {
  final String id;
  final bool isAnswer;
  RepliesParams({required this.id, required this.isAnswer});
}
