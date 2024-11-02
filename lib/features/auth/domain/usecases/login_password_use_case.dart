import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/core/usecase/usecase.dart';
import 'package:challange_beclever/features/auth/data/models/log_in_req_params.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';

class LoginPasswordUseCase
    implements UseCase<Either<String, Response>, LogInReqParams> {
  final AuthRepository authRepository;

  LoginPasswordUseCase({required this.authRepository});
  @override
  Future<Either<String, Response>> call(
          {required LogInReqParams param}) async =>
      authRepository.logIn(param);
}
