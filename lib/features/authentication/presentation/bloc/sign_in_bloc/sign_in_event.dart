part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInClick extends SignInEvent {
  final String phone;

  const SignInClick(this.phone);
}
