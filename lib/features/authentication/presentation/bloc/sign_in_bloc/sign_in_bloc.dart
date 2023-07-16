import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInUseCase signInUseCase;
  SignInBloc(this.signInUseCase) : super(SignInInitial()) {
    on<SignInClick>(_onSignInEvent);
  }
  _onSignInEvent(SignInClick event, Emitter<SignInState> emit) async {
    emit(SignInLoading());

    Either<Failure, bool> response =
        await signInUseCase(SignInParams(event.phone));

    response.fold((Failure failure) => emit(SignInFailure(failure.errorMessage)),
    (bool success) => emit(SignInSuccess()));
  }
}
