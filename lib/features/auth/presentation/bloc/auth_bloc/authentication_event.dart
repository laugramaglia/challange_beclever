part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class VerifyPhone extends AuthenticationEvent {
  final String phone;
  final String code;
  const VerifyPhone({
    required this.phone,
    required this.code,
  });
}

final class LogOut extends AuthenticationEvent {}
