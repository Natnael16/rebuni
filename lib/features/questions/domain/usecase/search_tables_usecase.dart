import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/questions_repository.dart';

class SearchUseCase implements UseCase<List<dynamic>, SearchParams> {
  final QuestionsRepository questionsRepository;

  SearchUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, List<dynamic>>> call(SearchParams searchParams) async {
    final Either<Failure, List<dynamic>> getReplysResult =
        await questionsRepository.searchTables(
           term:  searchParams.term, table: searchParams.table,
    sortBy: searchParams.sortBy,
    categories: searchParams.categories
    );
    return getReplysResult;
  }
}

class SearchParams {
  final String term;
  final String table;
  final String sortBy;
  final List<String> categories;
  SearchParams({required this.term, required this.table,required this.sortBy,required this.categories});
}
