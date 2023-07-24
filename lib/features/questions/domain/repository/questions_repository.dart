import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/question.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, bool>> postQuestion({
    required String title,
    required String description,
    File? image,
    required List<String> categories,
    required bool isAnonymous,
  });

  Future<Either<Failure, List<Question>>> getQuestions(int curIndex);
}
