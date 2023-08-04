part of 'otp_bloc_bloc.dart';

abstract class OtpBlocEvent extends Equatable {
  const OtpBlocEvent();

  @override
  List<Object> get props => [];
}

class VerifyOTP extends OtpBlocEvent {
  final String otp;
  final String phoneNumber;

  const VerifyOTP(this.otp, this.phoneNumber);
}
