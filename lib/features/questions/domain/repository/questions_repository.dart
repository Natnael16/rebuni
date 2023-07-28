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




}
