import 'package:challange_beclever/features/auth/domain/entities/user.dart';

class UserModel implements User {
  @override
  final String id;
  @override
  final String cedula;
  @override
  final String phoneNumber;
  UserModel(
      {required this.phoneNumber, required this.id, required this.cedula});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phoneNumber'] as String,
      cedula: map['cedula'] as String,
      id: map['id'] as String,
    );
  }

  @override
  List<Object?> get props => [phoneNumber, id];

  @override
  bool? get stringify => true;
}

extension UserXModel on UserModel {
  User toEntity() {
    return User(phoneNumber: phoneNumber, id: id, cedula: cedula);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'id': id,
      'cedula': cedula,
    };
  }
}
