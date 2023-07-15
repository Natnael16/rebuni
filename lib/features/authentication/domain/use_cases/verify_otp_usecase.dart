import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/user.dart';
import '../repository/sign_is_repository.dart';

class VerifyOTPUseCase implements UseCase<bool, VerifyOTPParams> {
  final UserRepository userRepository;

  VerifyOTPUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> call(VerifyOTPParams params) async {
    final phoneNumber = params.phoneNumber;
    final otp = params.otp;
    // Sign in the user
    final Either<Failure, bool> signInResult = await userRepository.verifyOTP(
      phoneNumber,otp
    );
    return signInResult;
  }
}

class VerifyOTPParams {
  final String phoneNumber;
  final String otp;

  VerifyOTPParams(this.phoneNumber, this.otp);
}
