import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/sign_is_repository.dart';

class ProviderSignInUseCase implements UseCase<bool, ProviderSignInParams> {
  final UserRepository userRepository;

  ProviderSignInUseCase(this.userRepository);

  @override
  Future<Either<Failure, bool>> call(ProviderSignInParams params) async {
    final provider = params.provider;
    // Sign in the user
    final Either<Failure, bool> ProviderSignInResult =
        await userRepository.providerSignIn(provider);
    return ProviderSignInResult;
  }
}

class ProviderSignInParams {
  final String provider;

  ProviderSignInParams(this.provider);
}
