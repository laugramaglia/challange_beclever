import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

part 'biometric_dart_state.dart';

class BiometricDartCubit extends Cubit<BiometricDartState> {
  final LocalAuthentication localAuth;
  BiometricDartCubit({required this.localAuth}) : super(BiometricDartInitial());

  Future<void> checkBiometrics() async {
    emit(BiometricCheckInProgress());

    try {
      // Check if device is capable of checking biometrics
      final isDeviceSupported = await localAuth.isDeviceSupported();
      final canCheckBiometrics = await localAuth.canCheckBiometrics;

      if (!isDeviceSupported) {
        emit(const BiometricUnavailable(
            'Este dispositivo no es compatible con autenticación biometrica.'));
        return;
      }

      if (!canCheckBiometrics) {
        emit(const BiometricUnavailable(
            'No se puede verificar los biometrías'));
        return;
      }

      // Get list of available biometrics
      final availableBiometrics = await localAuth.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        emit(const BiometricUnavailable('No disponible'));
      } else {
        emit(BiometricAvailable(availableBiometrics));
      }
    } catch (e) {
      emit(BiometricUnavailable(e.toString()));
    }
  }
}
