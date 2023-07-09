import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/user.dart';


abstract class UserRepository {
  Future<Either<Failure, User>> signIn(String phoneNumber);
}
