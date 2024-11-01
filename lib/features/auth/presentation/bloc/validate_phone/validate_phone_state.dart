part of 'validate_phone_cubit.dart';

@immutable
sealed class ValidatePhoneState {
  const ValidatePhoneState();
}

final class PhoneValidationInitial extends ValidatePhoneState {
  const PhoneValidationInitial();
}

final class PhoneValidationLoading extends ValidatePhoneState {
  const PhoneValidationLoading();
}

final class PhoneValidationSuccess extends ValidatePhoneState {
  final String message;
  const PhoneValidationSuccess(this.message);
}

final class PhoneValidationError extends ValidatePhoneState {
  final String error;
  const PhoneValidationError(this.error);
}
