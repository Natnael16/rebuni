import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repository/sign_is_repository.dart';
import '../datasource/supabase_data_source.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseDataSource supabaseDataSource;

  UserRepositoryImpl(this.supabaseDataSource);

  @override
  Future<Either<Failure, bool>> signIn(String phoneNumber) async {
    try {
      final status = await supabaseDataSource.signIn(phoneNumber);
      if (status == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure('User not found'));
      }
    } catch (e) {
      return Left(ServerFailure('Sign-in failed: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOTP(
      String phoneNumber, String otp) async {
    try {
      final status = await supabaseDataSource.verifyOTP(phoneNumber, otp);
      if (status == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure('Server error'));
      }
    } catch (e) {
      return Left(ServerFailure('Sign-in failed: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> signUp(
      String firstName, String? bio, File? profile,String? profileUrl) async {
    try {
      final status = await supabaseDataSource.signUp(firstName, bio, profile,profileUrl);
      if (status == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure('Sign-in failed'));
      }
    } catch (e) {
      return Left(ServerFailure('Sign-in failed: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFirstTime() async {
    try {
      final respose = await supabaseDataSource.isFirstTime();
      if (respose == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure('Is not first time user'));
      }
    } catch (e) {
      return Left(ServerFailure("Server error: $e"));
    }
  }
  
  @override
  Future<Either<Failure, bool>> providerSignIn(String provider) async {
    try {
      final respose = await supabaseDataSource.providerSignIn(provider);
      if (respose == true) {
        return const Right(true);
      } else {
        return Left(ServerFailure('Server error'));
      }
    } catch (e) {
      return Left(ServerFailure("Sign in failed : $e"));
    }
  }
}
