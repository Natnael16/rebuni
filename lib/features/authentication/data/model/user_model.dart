
import '../../domain/entity/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id, required super.phoneNumber,required super.isFirstTimeUser,super.otp});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      otp: json['otp'],
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      isFirstTimeUser: json['isFirstTimeUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otp' : otp,
      'id': id,
      'phoneNumber': phoneNumber,
      'isLoggedIn': isFirstTimeUser,
    };
  }
}
