import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecase/add_answer_usecase.dart';

part 'add_answer_event.dart';
part 'add_answer_state.dart';

class AddAnswerBloc extends Bloc<AddAnswerEvent, AddAnswerState> {
  PostAnswerUseCase addAnswer;
  AddAnswerBloc(this.addAnswer) : super(AddAnswerInitial()) {
    on<AddAnswer>(_onAddAnswer);
  }

  _onAddAnswer(AddAnswer event, Emitter<AddAnswerState> emit) async {
    emit(AddAnswerLoading());
    Either<Failure, bool> response = await addAnswer(
        PostAnswerParams(
          questionId: event.questionId,
          image: event.image,
          description: event.description,
        ),
        );

    response.fold(
        (Failure failure) => emit(AddAnswerFailure(failure.errorMessage)),
        (bool success) => emit(AddAnswerSuccess()));
  }
}
