import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rebuni/features/questions/domain/entity/question.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repository/questions_repository.dart';
import '../datasource/questions_supabase_datasource.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final SupabaseQuestionsDataSource questionsDataSource;

  QuestionsRepositoryImpl(this.questionsDataSource);

  @override
  Future<Either<Failure, bool>> postQuestion({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required bool isAnonymous,
  }) async {
    try {
      final bool result = await questionsDataSource.postQuestion(
        title: title,
        description: description,
        image: image,
        categories: categories,
        isAnonymous: isAnonymous,
      );
      if (!result) {
        throw Exception("Failed to post question");
      }
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getQuestions(int curIndex) async {
    try {
      final List<Question> result = await questionsDataSource.getQuestions(curIndex);
      return Right(result);
    } catch (e) {
      print('get error $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
