import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> signIn(String phoneNumber);
  Future<Either<Failure, bool>> verifyOTP(String phoneNumber, String otp);
  Future<Either<Failure, bool>> signUp(
      String firstName, String? bio, File? profile,String? profileUrl);
  Future<Either<Failure, bool>> isFirstTime();
  Future<Either<Failure, bool>> providerSignIn(String provider);
}
