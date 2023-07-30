import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rebuni/features/questions/domain/entity/answer.dart';
import 'package:rebuni/features/questions/domain/entity/discussion.dart';
import 'package:rebuni/features/questions/domain/entity/question.dart';
import 'package:rebuni/features/questions/domain/entity/reply.dart';

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
      final List<Question> result =
          await questionsDataSource.getQuestions(curIndex);
      return Right(result);
    } catch (e) {
      print('get error $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Answer>>> getAnswers(String questionId) async {
    try {
      final List<Answer> result =
          await questionsDataSource.getAnswers(questionId);
      return Right(result);
    } catch (e) {
      print('get error $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Discussion>>> getDiscussions(
      String questionId) async {
    try {
      final List<Discussion> result =
          await questionsDataSource.getDiscussions(questionId);
      return Right(result);
    } catch (e) {
      print('get error $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Reply>>> getReplies(
      String id, bool isQuestion) async {
    try {
      final List<Reply> result =
          await questionsDataSource.getReplies(id, isQuestion);
      return Right(result);
    } catch (e) {
      print('get error $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addReply(
      {required String id,
      required String body,
      required bool isQuestion}) async {
    try {
      final bool result = await questionsDataSource.addReply(
        id,
        body,
        isQuestion,
      );
      if (!result) {
        throw Exception("Failed to add reply");
      }
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> postAnswer({required String questionId, required String description, File? image}) async {
    try {
      final bool result = await questionsDataSource.postAnswer(
        questionId: questionId,
        description: description,
        image: image,
      );
      if (!result) {
        throw Exception("Failed to post Answer");
      }
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }   
}
