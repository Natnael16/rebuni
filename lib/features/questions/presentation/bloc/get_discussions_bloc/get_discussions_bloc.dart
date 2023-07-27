import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entity/discussion.dart';
import '../../../domain/usecase/get_discussions_usecase.dart';

part 'get_discussions_event.dart';
part 'get_discussions_state.dart';

class GetDiscussionsBloc
    extends Bloc<GetDiscussionsEvent, GetDiscussionsState> {
  GetDiscussionsUseCase getDiscussions;
  GetDiscussionsBloc(this.getDiscussions) : super(GetDiscussionsInitial()) {
    on<GetDiscussions>(_onGetDiscussions);
  }
  _onGetDiscussions(GetDiscussions event, Emitter emit) async {
    emit(GetDiscussionsLoading());
    var response = await getDiscussions(event.questionId);
    response.fold(
        (Failure failure) => emit(GetDiscussionsFailure(failure.errorMessage)),
        (List<Discussion> success) => emit(GetDiscussionsSuccess(success)));
  }
}
