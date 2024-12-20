import 'package:challange_beclever/features/auth/data/models/create_pass_req_params.dart';
import 'package:challange_beclever/features/auth/data/models/log_in_req_params.dart';
import 'package:challange_beclever/features/auth/data/models/user.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/domain/entities/user.dart';
import 'package:challange_beclever/features/auth/domain/usecases/create_password_use_case.dart';
import 'package:challange_beclever/features/auth/domain/usecases/login_password_use_case.dart';
import 'package:challange_beclever/features/auth/domain/usecases/logout.dart';
import 'package:challange_beclever/features/auth/domain/usecases/validate_phone_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ValidatePhoneCase validatePhoneCase;
  final LogoutUseCase logoutUseCase;
  final CreatePasswordUseCase createPasswordUseCase;
  final LoginPasswordUseCase loginPasswordUseCase;

  AuthenticationBloc({
    required this.validatePhoneCase,
    required this.logoutUseCase,
    required this.createPasswordUseCase,
    required this.loginPasswordUseCase,
  }) : super(const AuthInitial()) {
    on<ResetState>(_onResetState);
    on<VerifyPhone>(_onVerifyPhone);
    on<CreatePassword>(_onCreatePassword);
    on<LoginPassword>(_onLoginPassword);
    on<LogOut>(_onLogOut);
  }

  User? _user;

  Future<void> _onVerifyPhone(
    VerifyPhone event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthLoading());
    final res = await validatePhoneCase.call(
      param: ValidatePhoneReqParams(
          phoneNumber: event.phone, code: event.code, cedula: event.cedula),
    );

    res.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (response) {
        _user = UserModel.fromMap(response.data['value']);

        emit(AuthSuccess(_user!));
      },
    );
  }

  Future<void> _onCreatePassword(
    CreatePassword event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthLoading());
    await createPasswordUseCase.call(
        param: CreatePassReqParams(
            password: event.password, useBiometric: event.useBiometric));
    if (_user == null) {
      emit(const AuthError('User not found'));
      return;
    }
    emit(AuthSuccess(_user!));
  }

  Future<void> _onLoginPassword(
      LoginPassword event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    final response = await loginPasswordUseCase.call(
        param:
            LogInReqParams(password: event.password, cedula: event.idNumber));

    response.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (response) {
        _user = UserModel.fromMap(response.data['value']);

        emit(AuthSuccess(_user!));
      },
    );
  }

  Future<void> _onLogOut(
    LogOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await logoutUseCase.call();
    emit(const AuthInitial());
  }

  void _onResetState(ResetState event, Emitter<AuthenticationState> emit) {
    emit(const AuthInitial());
  }
}
