import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entity/reply.dart';
import '../../../domain/usecase/get_replies_usecase.dart';

part 'get_replies_event.dart';
part 'get_replies_state.dart';

class GetRepliesBloc extends Bloc<GetRepliesEvent, GetRepliesState> {
  GetRepliesUseCase getReplies;
  GetRepliesBloc(this.getReplies) : super(GetRepliesInitial()) {
    on<GetReplies>(_onGetReplies);
  }
  _onGetReplies(GetReplies event, Emitter emit) async {
    emit(GetRepliesLoading());
    var response = await getReplies(RepliesParams(id: event.id,  isAnswer: event.isAnswer));
    response.fold(
        (Failure failure) => emit(GetRepliesFailure(failure.errorMessage)),
        (List<Reply> success) => emit(GetRepliesSuccess(success)));
  }
}
