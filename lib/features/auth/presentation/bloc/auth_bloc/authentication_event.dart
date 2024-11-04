part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class ResetState extends AuthenticationEvent {}

final class VerifyPhone extends AuthenticationEvent {
  final String phone;
  final String code;
  final String cedula;

  const VerifyPhone({
    required this.phone,
    required this.code,
    required this.cedula,
  });
}

/// Create Password
/// As you are authenticated you can create your password
final class CreatePassword extends AuthenticationEvent {
  final String password;
  final bool useBiometric;

  const CreatePassword({
    required this.password,
    this.useBiometric = false,
  });
}

final class LoginPassword extends AuthenticationEvent {
  final String idNumber;
  final String password;
  const LoginPassword({
    required this.idNumber,
    required this.password,
  });
}

final class LogOut extends AuthenticationEvent {}
