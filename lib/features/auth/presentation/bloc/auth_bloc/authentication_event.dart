part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

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

final class LogOut extends AuthenticationEvent {}
