import 'dart:developer';

import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/data/source/auth_api_service.dart';
import 'package:challange_beclever/features/auth/data/source/auth_local_service.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<String, Response>> validatePhone(
      ValidatePhoneReqParams param) async {
    final result = await sl<AuthApiService>().validatePhone(param);
    log('result $result');
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;

      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> logout() async {
    return await sl<AuthLocalService>().logout();
  }
}
