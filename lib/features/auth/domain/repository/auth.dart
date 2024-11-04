import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/models/create_pass_req_params.dart';
import 'package:challange_beclever/features/auth/data/models/log_in_req_params.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<String, Response>> validatePhone(ValidatePhoneReqParams param);
  Future<Either<String, Response>> createPassword(CreatePassReqParams phone);

  Future<Either<String, Response>> logIn(LogInReqParams param);

  Future<Either<String, Response>> getUser();

  Future<void> logOut();
}
