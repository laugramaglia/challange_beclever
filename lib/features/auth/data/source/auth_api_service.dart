import 'dart:convert';

import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/validate_phone_req_params.dart';

abstract class AuthApiService {
  Future<Either<String, Response>> validatePhone(ValidatePhoneReqParams params);
  Future<Either<String, Response>> login(
      {required Map<String, dynamic> params});

  Future<Either<String, Response>> getUser();
}

class AuthApiServiceImpl extends AuthApiService {
  final DioClientFake network;
  late final SharedPreferences prefs;

  AuthApiServiceImpl({required this.network, required this.prefs});
  @override
  Future<Either<String, Response>> validatePhone(
      ValidatePhoneReqParams params) async {
    final response =
        await network.post('/validate-phone', data: params.toMap());

    if (response.statusCode == 201) {
      prefs.setString('token', response.data['token']);

      // just saving to validate user later on
      prefs.setString('user', jsonEncode(response.data['value']));
      return Right(response);
    }
    if (prefs.containsKey('token')) {
      prefs.remove('token');
    }
    return Left(response.data['message']);
  }

  @override
  Future<Either<String, Response>> login(
      {required Map<String, dynamic> params}) async {
    final response = await network.post('/login', data: params);

    if (response.statusCode == 200) {
      return Right(response);
    }

    return Left(response.data['message']);
  }

  @override
  Future<Either<String, Response>> getUser() async {
    final response = await Future.delayed(
        const Duration(seconds: 1),
        () => Response(
              data: {'user': jsonDecode(prefs.getString('user')!)},
              statusCode: 200,
            ));

    if (response.statusCode == 200) {
      return Right(response);
    }
    return Left(response.data['message']);
  }
}
