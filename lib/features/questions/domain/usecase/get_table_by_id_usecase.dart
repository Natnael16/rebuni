import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/questions_repository.dart';

class GetTableById implements UseCase<dynamic, TableByIdParams> {
  final QuestionsRepository questionsRepository;

  GetTableById(this.questionsRepository);

  @override
  Future<Either<Failure, dynamic>> call(TableByIdParams tableByIdParams) async {
    final Either<Failure, dynamic> getReplysResult =
        await questionsRepository.getTableById(
            tableByIdParams.table, tableByIdParams.id);
    return getReplysResult;
  }
}

class TableByIdParams {
  final String table;
  final dynamic id;
  TableByIdParams({required this.id, required this.table});
}
