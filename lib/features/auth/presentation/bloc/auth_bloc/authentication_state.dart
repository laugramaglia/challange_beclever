part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

final class AuthInitial extends AuthenticationState {
  const AuthInitial();
}

final class AuthLoading extends AuthenticationState {}

final class AuthError extends AuthenticationState {
  final String message;
  const AuthError(this.message);
}

final class AuthSuccess extends AuthenticationState {
  final User user;
  const AuthSuccess(this.user);
}
