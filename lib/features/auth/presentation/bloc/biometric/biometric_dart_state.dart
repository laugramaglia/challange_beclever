part of 'biometric_dart_cubit.dart';

// Cubit States
sealed class BiometricDartState extends Equatable {
  const BiometricDartState();

  @override
  List<Object> get props => [];
}

final class BiometricDartInitial extends BiometricDartState {}

final class BiometricCheckInProgress extends BiometricDartState {}

final class BiometricAvailable extends BiometricDartState {
  final List<BiometricType> availableBiometrics;

  const BiometricAvailable(this.availableBiometrics);

  @override
  List<Object> get props => [availableBiometrics];
}

final class BiometricUnavailable extends BiometricDartState {
  final String reason;

  const BiometricUnavailable(this.reason);

  @override
  List<Object> get props => [reason];
}
