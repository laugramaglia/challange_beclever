import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/domain/usecases/validate_phone_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validate_phone_state.dart';

class ValidatePhoneCubit extends Cubit<ValidatePhoneState> {
  ValidatePhoneCubit() : super(const PhoneValidationInitial());

  Future<void> validatePhone(ValidatePhoneReqParams param) async {
    try {
      emit(const PhoneValidationLoading());

      final response = await sl<ValidatePhoneCase>().call(param: param);

      response.fold((error) => emit(PhoneValidationError(error)), (response) {
        emit(const PhoneValidationSuccess('Código válido'));
      });
    } catch (e) {
      emit(PhoneValidationError('Error: ${e.toString()}'));
    }
  }
}
