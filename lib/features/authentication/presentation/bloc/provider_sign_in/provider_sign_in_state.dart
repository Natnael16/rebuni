part of 'provider_sign_in_bloc.dart';

abstract class ProviderSignInState extends Equatable {
  const ProviderSignInState();

  @override
  List<Object> get props => [];
}

class ProviderSignInInitial extends ProviderSignInState {}

class ProviderSignInLoading extends ProviderSignInState {
  final String provider;
  const ProviderSignInLoading(this.provider);
}

class ProviderSignInSuccess extends ProviderSignInState {
  final String provider;
  const ProviderSignInSuccess(this.provider);
}

class ProviderSignInFailure extends ProviderSignInState {
  final String errorMessage;

  const ProviderSignInFailure(this.errorMessage);
}
