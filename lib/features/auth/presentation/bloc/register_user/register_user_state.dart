part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {
  final String idNumber;
  final String pohneNumber;
  final bool isNumberVerified;
  final String password;
  final String confirmPassword;
  final bool useBiometric;

  const RegisterUserState({
    required this.idNumber,
    required this.pohneNumber,
    required this.isNumberVerified,
    required this.password,
    required this.confirmPassword,
    required this.useBiometric,
  });

  bool get isPasswordMatched =>
      password == confirmPassword && password.isNotEmpty;

  RegisterUserState copyWith({
    String? idNumber,
    String? pohneNumber,
    bool? isNumberVerified,
    String? password,
    String? confirmPassword,
    bool? useBiometric,
  });

  @override
  String toString() =>
      'RegisterUserState(idNumber: $idNumber, pohneNumber: $pohneNumber, isNumberVerified: $isNumberVerified, password: $password, confirmPassword: $confirmPassword, useBiometric: $useBiometric)';
}

final class RegisterUserInitial extends RegisterUserState {
  const RegisterUserInitial({
    super.idNumber = '',
    super.pohneNumber = '',
    super.isNumberVerified = false,
    super.password = '',
    super.confirmPassword = '',
    super.useBiometric = false,
  });

  @override
  RegisterUserState copyWith({
    String? idNumber,
    String? pohneNumber,
    bool? isNumberVerified,
    String? password,
    String? confirmPassword,
    bool? useBiometric,
  }) =>
      RegisterUserInitial(
        idNumber: idNumber ?? this.idNumber,
        pohneNumber: pohneNumber ?? this.pohneNumber,
        isNumberVerified: isNumberVerified ?? this.isNumberVerified,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        useBiometric: useBiometric ?? this.useBiometric,
      );
}
