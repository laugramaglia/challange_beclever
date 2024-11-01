import 'package:challange_beclever/features/auth/data/models/user.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/domain/entities/user.dart';
import 'package:challange_beclever/features/auth/domain/usecases/validate_phone_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ValidatePhoneCase validatePhoneCase;

  AuthenticationBloc({required this.validatePhoneCase})
      : super(const AuthInitial()) {
    on<VerifyPhone>(_onVerifyPhone);
    on<LogOut>(_onLogOut);
    on<AuthenticationEvent>((_, emit) => emit(AuthLoading()));
  }

  Future<void> _onVerifyPhone(
    VerifyPhone event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthLoading());
    final res = await validatePhoneCase(
      param: ValidatePhoneReqParams(
          phoneNumber: event.phone, code: event.code, cedula: event.cedula),
    );

    res.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (response) {
        final user = UserModel.fromMap(response.data['value']);
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _onLogOut(
    LogOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthInitial());
  }
}
