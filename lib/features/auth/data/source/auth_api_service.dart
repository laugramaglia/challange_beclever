import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:dartz/dartz.dart';

import '../models/validate_phone_req_params.dart';

abstract class AuthApiService {
  Future<Either<String, Response>> validatePhone(ValidatePhoneReqParams params);

  Future<Either<String, Response>> createPassword(String password);
  Future<Either<String, Response>> login(
      {required Map<String, dynamic> params});

  Future<Either<String, Response>> getUser();
}

class AuthApiServiceImpl extends AuthApiService {
  final DioClientFake network;

  AuthApiServiceImpl({required this.network});
  @override
  Future<Either<String, Response>> validatePhone(
      ValidatePhoneReqParams params) async {
    final response =
        await network.post('/validate-phone', data: params.toMap());

    if (response.statusCode == 201) {
      return Right(response);
    }

    return Left(response.data['message']);
  }

  @override
  Future<Either<String, Response>> login(
      {required Map<String, dynamic> params}) async {
    final response = await network.post('/login', data: params);

    if (response.statusCode == 201) {
      return Right(response);
    }

    return Left(response.data['message']);
  }

  @override
  Future<Either<String, Response>> getUser() async {
    final response = await network.get('/user');

    if (response.statusCode == 200) {
      return Right(response);
    }
    return Left(response.data['message']);
  }

  @override
  Future<Either<String, Response>> createPassword(String password) async {
    final resposponse =
        await network.patch('/create-password', data: {'password': password});

    if (resposponse.statusCode == 201) {
      return Right(resposponse);
    }
    return Left(resposponse.data['message']);
  }
}
