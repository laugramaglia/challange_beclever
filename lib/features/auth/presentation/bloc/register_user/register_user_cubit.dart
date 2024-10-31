import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit() : super(const RegisterUserInitial());

  void updateIdNumber(String idNumber) {
    emit(state.copyWith(idNumber: idNumber));
  }

  void updatePhoneNumber(String pohneNumber) {
    emit(state.copyWith(pohneNumber: pohneNumber));
  }
}
