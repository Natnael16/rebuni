import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/sign_is_repository.dart';

class FirstTimeUseCase implements UseCase<bool, NoParams> {
  final UserRepository userRepository;

  FirstTimeUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    // Sign in the user
    final Either<Failure, bool> FirstTimeResult =
        await userRepository.isFirstTime();
    return FirstTimeResult;
  }
}

