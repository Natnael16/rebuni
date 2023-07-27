import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entity/answer.dart';
import '../../../domain/usecase/get_answers_usecase.dart';

part 'get_answers_event.dart';
part 'get_answers_state.dart';

class GetAnswersBloc extends Bloc<GetAnswersEvent, GetAnswersState> {
  final GetAnswersUseCase getAnswers;
  
  GetAnswersBloc(this.getAnswers) : super(GetAnswersInitial()) {
    on<GetAnswers>(_onGetAnswers);
  }

  _onGetAnswers(GetAnswers event, Emitter emit) async {
    emit(GetAnswersLoading());
    var response = await getAnswers(event.questionId);
    response.fold(
        (Failure failure) => emit(GetAnswersFailure(failure.errorMessage)),
        (List<Answer> success) => emit(GetAnswersSuccess(success)));
  }
}
