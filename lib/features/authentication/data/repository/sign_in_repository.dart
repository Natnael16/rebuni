import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/sign_is_repository.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseDataSource supabaseDataSource;

  UserRepositoryImpl(this.supabaseDataSource);

  @override
  Future<Either<Failure, User>> signIn(String phoneNumber) async {
    try {
      final UserModel? userModel = await supabaseDataSource.signIn(phoneNumber);
      if (userModel != null) {
        final User user = User(
          id: userModel.id,
          phoneNumber: userModel.phoneNumber,
          isFirstTimeUser: userModel.isFirstTimeUser,
        );
        return Right(user);
      } else {
        return Left(ServerFailure('User not found'));
      }
    } catch (e) {
      return Left(ServerFailure('Sign-in failed: $e'));
    }
  }

}
