
import '../../domain/entity/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id, required super.phoneNumber,required});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
    };
  }
}
