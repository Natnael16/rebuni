import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/questions_repository.dart';

class VoteUseCase implements UseCase<bool, VoteParams> {
  final QuestionsRepository questionsRepository;

  VoteUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, bool>> call(VoteParams params) async {
    final String id = params.id;
    final String table = params.table;
    final bool voteType = params.voteType;
    // Sign in the user
    final Either<Failure, bool> signUpResult =
        await questionsRepository.addVote(
      id: id,
      table: table,
      voteType: voteType,
    );
    return signUpResult;
  }
}

class VoteParams {
  final String id;
  final bool voteType;
  final String table;

  VoteParams(
      {required this.id, required this.voteType, required this.table});
}
