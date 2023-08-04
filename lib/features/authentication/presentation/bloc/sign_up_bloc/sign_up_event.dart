part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class CompleteProfile extends SignUpEvent {
  final String fullName;
  final String? bio;
  final File? profilePicture;

  const CompleteProfile({required this.fullName, this.bio, this.profilePicture});
}
