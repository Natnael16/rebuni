import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String phoneNumber;
  final bool isFirstTimeUser;
  final String? otp;

  User(
      {
      this.otp,
      required this.id,
      required this.phoneNumber,
      required this.isFirstTimeUser});

  @override
  List<Object?> get props => [id, phoneNumber, isFirstTimeUser,otp];
}
