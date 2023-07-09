import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/user.dart';
import '../repository/sign_is_repository.dart';


class SignInUseCase implements UseCase<User, SignInParams> {
  final UserRepository userRepository;

  SignInUseCase(this.userRepository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
      final phoneNumber = params.phoneNumber;
      // Sign in the user
      final Either<Failure, User> signInResult = await userRepository.signIn(phoneNumber);
      return signInResult;
    
  }
}

class SignInParams {
  final String phoneNumber;

  SignInParams(this.phoneNumber);
}