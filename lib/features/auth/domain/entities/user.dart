import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String cedula;
  final String phoneNumber;

  const User({
    required this.id,
    required this.cedula,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber, id, cedula];

  static const User empty = User(id: '', phoneNumber: '', cedula: '');
}
