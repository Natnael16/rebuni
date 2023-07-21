import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entity/question.dart';
import '../../../domain/usecase/get_questions_usecase.dart';
import 'package:stream_transform/stream_transform.dart';
part 'get_questions_event.dart';
part 'get_questions_state.dart';

const throttleDuration = Duration(seconds: 3);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class GetQuestionsBloc extends Bloc<GetQuestionsEvent, GetQuestionsState> {
  GetQuestionsUseCase getQuestions;
  GetQuestionsBloc(this.getQuestions) : super(GetQuestionsInitial()) {
    on<GetQuestions>(
      _onGetQuestions,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  _onGetQuestions(GetQuestions event, Emitter<GetQuestionsState> emit) async {
    Either<Failure, List<Question>> response;

    var curState = state;
    if (curState is QuestionsLoaded) {
      response = await getQuestions(curState.questions.length);
    } else {
      emit(GetQuestionsLoading());
      response = await getQuestions(0);
    }

    response.fold(
        (Failure failure) => emit(GetQuestionsFailure(failure.errorMessage)),
        (List<Question> success) {
      if (curState is QuestionsLoaded) {
        var appendedList = List.of(curState.questions)..addAll(success);
        emit((QuestionsLoaded(appendedList, success.isEmpty)));
      } else if (curState is GetQuestionsInitial) {
        emit(QuestionsLoaded(success));
      }
    });
  }
}
