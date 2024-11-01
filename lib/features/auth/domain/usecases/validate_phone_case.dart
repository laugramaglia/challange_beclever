import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/core/usecase/usecase.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';

class ValidatePhoneCase
    implements UseCase<Either<String, Response>, ValidatePhoneReqParams> {
  @override
  Future<Either<String, Response>> call(
          {ValidatePhoneReqParams? param}) async =>
      sl<AuthRepository>().validatePhone(param!);
}
