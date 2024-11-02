import 'dart:async';

import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/data/source/auth_api_service.dart';
import 'package:challange_beclever/features/auth/data/source/auth_local_service.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalService authLocalService;
  final AuthApiService authApiService;
  AuthRepositoryImpl({
    required this.authLocalService,
    required this.authApiService,
  });

  final StreamController<AuthenticationStatus> _controller =
      StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  @override
  Future<Either<String, Response>> validatePhone(
      ValidatePhoneReqParams param) async {
    final result = await authApiService.validatePhone(param);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      authLocalService.setToken(data.data['token']);
      _controller.add(AuthenticationStatus.authenticated);
      return Right(data);
    });
  }

// example
  Future<Either<String, Response>> logIn({
    required String phone,
    required String password,
  }) async {
    // Simulated authentication logic
    // In a real implementation, you'd call an authentication service
    final response = await authApiService.login(params: {
      'phone': phone,
      'password': password,
    });
    return await Future.delayed(
      const Duration(seconds: 1),
      () {
        return response.fold(
          (error) {
            return Left(error);
          },
          (data) {
            authLocalService.setToken(data.data['token']);
            _controller.add(AuthenticationStatus.authenticated);
            return Right(data);
          },
        );
      },
    );
  }

  @override
  Future<void> logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    return Future.value();
  }

  void dispose() => _controller.close();

  @override
  Future<Either<String, Response>> getUser() {
    return authApiService.getUser();
  }
}
