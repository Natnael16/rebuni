import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/sign_is_repository.dart';


class SignInUseCase implements UseCase<bool, SignInParams> {
  final UserRepository userRepository;

  SignInUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> call(SignInParams params) async {
      final phoneNumber = params.phoneNumber;
      // Sign in the user
      final Either<Failure, bool> signInResult = await userRepository.signIn(phoneNumber);
      return signInResult;
    
  }
}

class SignInParams {
  final String phoneNumber;

  SignInParams(this.phoneNumber);
}