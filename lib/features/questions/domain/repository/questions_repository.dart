import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/answer.dart';
import '../entity/discussion.dart';
import '../entity/question.dart';
import '../entity/reply.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, bool>> postQuestion({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required bool isAnonymous,
  });

  Future<Either<Failure, List<Question>>> getQuestions(int curIndex);

  Future<Either<Failure, List<Answer>>> getAnswers(String questionId);

  Future<Either<Failure, List<Discussion>>> getDiscussions(String questionId);

  Future<Either<Failure, List<Reply>>> getReplies(String id, bool isAnswer);

  Future<Either<Failure, bool>> addReply(
      {required String id, required String body, required bool isQuestion});

  Future<Either<Failure, bool>> postAnswer({
    required String questionId,
    required String description,
    File? image,
  });

  Future<Either<Failure, bool>> addVote({
    required String id,
    required bool voteType,
    required String table,
  });

  Future<Either<Failure, List<dynamic>>> searchTables({
    required String term,
    required String table,
    required String sortBy,
    required List<String> categories,
  });

  Future<Either<Failure, dynamic>> getTableById(String table, dynamic id);

  Future<Either<Failure, List<Question>>> getBookmarks();

  Future<Either<Failure, bool>> addBookmark(String questionId);


}
