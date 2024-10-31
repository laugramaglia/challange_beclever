part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {
  final String idNumber;
  final String pohneNumber;

  final bool isNumberVerified;

  const RegisterUserState({
    required this.idNumber,
    required this.pohneNumber,
    required this.isNumberVerified,
  });

  RegisterUserState copyWith({
    String? idNumber,
    String? pohneNumber,
    bool? isNumberVerified,
  });

  @override
  String toString() =>
      'RegisterUserState(idNumber: $idNumber, pohneNumber: $pohneNumber, isNumberVerified: $isNumberVerified)';
}

final class RegisterUserInitial extends RegisterUserState {
  const RegisterUserInitial({
    super.idNumber = '',
    super.pohneNumber = '',
    super.isNumberVerified = false,
  });

  @override
  RegisterUserState copyWith({
    String? idNumber,
    String? pohneNumber,
    bool? isNumberVerified,
  }) =>
      RegisterUserInitial(
        idNumber: idNumber ?? this.idNumber,
        pohneNumber: pohneNumber ?? this.pohneNumber,
        isNumberVerified: isNumberVerified ?? this.isNumberVerified,
      );
}
