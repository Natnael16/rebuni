import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/provider_sign_in_usecase.dart';

part 'provider_sign_in_event.dart';
part 'provider_sign_in_state.dart';

class ProviderSignInBloc
    extends Bloc<ProviderSignInEvent, ProviderSignInState> {
  ProviderSignInUseCase providerSignin;
  ProviderSignInBloc(this.providerSignin) : super(ProviderSignInInitial()) {
    on<ContinueWithProvider>(_onProviderSignInEvent);
  }
  _onProviderSignInEvent(
      ContinueWithProvider event, Emitter<ProviderSignInState> emit) async {
    emit(ProviderSignInLoading(event.provider));

    Either<Failure, bool> response =
        await providerSignin(ProviderSignInParams(event.provider));

    response.fold(
        (Failure failure) => emit(ProviderSignInFailure(failure.errorMessage)),
        (bool success) => emit(ProviderSignInSuccess(event.provider)),);
  }
}
