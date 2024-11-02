import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_password_state.dart';

class LoginPasswordCubit extends Cubit<LoginPasswordState> {
  LoginPasswordCubit() : super(const LoginPasswordInitial());

  void updateIdNumber(String idNumber) {
    emit(state.copyWith(idNumber: idNumber));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }
}
