import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/profile_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpBloc(this.signUpUseCase) : super(SignUpInitial()) {
    on<CompleteProfile>(_onSignUp);
  }

  _onSignUp(CompleteProfile event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());

    Either<Failure, bool> response =
        await signUpUseCase(SignUpParams(fullName: event.fullName, bio: event.bio, profilePicture: event.profilePicture));
    
    response.fold((Failure failure) => emit(SignUpFailure()),
        (bool success) => emit(SignUpSuccess()));
  }
}
