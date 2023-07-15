import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/user.dart';
import '../repository/sign_is_repository.dart';

class SignUpUseCase implements UseCase<bool, SignUpParams> {
  final UserRepository userRepository;

  SignUpUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> call(SignUpParams params) async {
    final name = params.fullName;
    final bio = params.bio;
    final pic = params.profilePicture;
    // Sign in the user
    final Either<Failure, bool> signUpResult =
        await userRepository.signUp(name, bio, pic);
    return signUpResult;
  }
}

class SignUpParams {
  final String fullName;
  final String? bio;
  final File? profilePicture;

  SignUpParams({required this.fullName, this.bio, this.profilePicture});
}
