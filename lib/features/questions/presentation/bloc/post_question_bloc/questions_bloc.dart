import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecase/post_question_usecase.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  PostQuestionUseCase postQuestion;
  
  QuestionsBloc(this.postQuestion) : super(QuestionsInitial()) {
    on<PostQuestion>(_onPostQuestion);

  }
  _onPostQuestion(PostQuestion event, Emitter<QuestionsState> emit) async  {
    emit(PostQuestionLoading());
    Either<Failure, bool> response =
        await postQuestion(PostAnswerParams(categories: event.categories,image: event.image,title: event.title,description: event.description,isAnonymous: event.isAnonymous));

    response.fold((Failure failure) => emit(PostQuestionFailure(failure.errorMessage)),
    (bool success) => emit(PostQuestionSuccess()));

  }
}
