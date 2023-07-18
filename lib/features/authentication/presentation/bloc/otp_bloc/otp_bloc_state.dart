part of 'otp_bloc_bloc.dart';

abstract class OtpBlocState extends Equatable {
  const OtpBlocState();
  
  @override
  List<Object> get props => [];
}

class OtpBlocInitial extends OtpBlocState {}

class VerifyOtpLoading extends OtpBlocState{}

class VerifyOtpSuccess extends OtpBlocState{}

class VerifyOtpFailure extends OtpBlocState{}
