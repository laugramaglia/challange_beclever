import 'package:challange_beclever/features/auth/domain/entities/user.dart';

class UserModel implements UserEntity {
  @override
  final String phoneNumber;
  UserModel({required this.phoneNumber});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phoneNumber'] as String,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(phoneNumber: phoneNumber);
  }
}
