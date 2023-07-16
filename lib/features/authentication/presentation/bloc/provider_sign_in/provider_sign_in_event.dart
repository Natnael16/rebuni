part of 'provider_sign_in_bloc.dart';

abstract class ProviderSignInEvent extends Equatable {
  const ProviderSignInEvent();

  @override
  List<Object> get props => [];
}

class ContinueWithProvider extends ProviderSignInEvent {
  final String provider;

  const ContinueWithProvider( this.provider);
}
