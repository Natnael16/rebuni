import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/verify_otp_usecase.dart';

part 'otp_bloc_event.dart';
part 'otp_bloc_state.dart';

class OtpBlocBloc extends Bloc<OtpBlocEvent, OtpBlocState> {
  VerifyOTPUseCase verify;
  OtpBlocBloc(this.verify) : super(OtpBlocInitial()) {
    on<VerifyOTP>(_onVerifyOtp);
  }
  _onVerifyOtp(VerifyOTP event, Emitter<OtpBlocState> emit) async {
    emit(VerifyOtpLoading());

    Either<Failure, bool> response =
        await verify(VerifyOTPParams(event.phoneNumber,event.otp));

    response.fold(
        (Failure failure) => emit(VerifyOtpFailure()),
        (bool success) => emit(VerifyOtpSuccess()));
  }
}
