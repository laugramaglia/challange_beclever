import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, Response>> validatePhone(ValidatePhoneReqParams param);

  Future<bool> isLoggedIn();
  Future<Either> logout();
}
