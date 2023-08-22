import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rebuni/features/questions/domain/entity/answer.dart';
import 'package:rebuni/features/questions/domain/entity/discussion.dart';
import 'package:rebuni/features/questions/domain/entity/question.dart';
import 'package:rebuni/features/questions/domain/entity/reply.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repository/questions_repository.dart';
import '../datasource/questions_supabase_datasource.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final SupabaseQuestionsDataSource questionsDataSource;
  InternetConnectionChecker checker = InternetConnectionChecker();


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
  Future<Either<Failure, bool>> postAnswer(
      {required String questionId,
      required String description,
      File? image}) async {
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

  @override
  Future<Either<Failure, bool>> addVote(
      {required String id,
      required bool voteType,
      required String table}) async {
    if (!await checker.hasConnection) {
      return const Left(NetworkFailure('No Internet connection'));
    }
    try {
      final bool result = await questionsDataSource.addVote(
        id: id,
        voteType: voteType,
        table: table,
      );
      if (!result) {
        throw Exception("Failed to vote");
      }
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<dynamic>>> searchTables({required String term, required String table, required String sortBy, required List<String> categories, File? image}) async {
    try {
      final List<dynamic> result =
          await questionsDataSource.searchTables(
          term: term,
          table: table,
          sortBy: sortBy,
          categories: categories);
      ;
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, dynamic>> getTableById(String table, id) async {
    if (!await checker.hasConnection) {
      return const Left(NetworkFailure('No Internet connection'));
    }
    try {
      final dynamic result = await questionsDataSource.getTableById(
          table,id);
      ;
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }

  }
}
