part of 'login_password_cubit.dart';

sealed class LoginPasswordState extends Equatable {
  final String idNumber;
  final String password;
  const LoginPasswordState({required this.idNumber, required this.password});

  @override
  List<Object> get props => [idNumber, password];

  copyWith({String? idNumber, String? password});

  bool get hasCredentials => idNumber.isNotEmpty && password.isNotEmpty;

  @override
  String toString() =>
      'LoginPasswordState(idNumber: $idNumber, password: $password)';
}

final class LoginPasswordInitial extends LoginPasswordState {
  const LoginPasswordInitial({super.idNumber = '', super.password = ''});

  @override
  copyWith({
    String? idNumber,
    String? password,
  }) {
    return LoginPasswordInitial(
      idNumber: idNumber ?? this.idNumber,
      password: password ?? this.password,
    );
  }
}
