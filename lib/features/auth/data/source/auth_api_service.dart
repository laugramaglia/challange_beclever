import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:dartz/dartz.dart';

import '../models/validate_phone_req_params.dart';

abstract class AuthApiService {
  Future<Either<String, Response>> validatePhone(ValidatePhoneReqParams params);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<String, Response>> validatePhone(
      ValidatePhoneReqParams params) async {
    final response =
        await sl<DioClientFake>().post('/validate-phone', data: params.toMap());

    if (response.statusCode == 201) {
      return Right(response);
    }

    return Left(response.data['message']);
  }
}
