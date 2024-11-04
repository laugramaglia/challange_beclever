import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/core/usecase/usecase.dart';
import 'package:challange_beclever/features/auth/data/models/create_pass_req_params.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';
import 'package:dartz/dartz.dart';

class CreatePasswordUseCase
    implements UseCase<Either<String, Response>, CreatePassReqParams> {
  final AuthRepository authRepository;
  const CreatePasswordUseCase({required this.authRepository});
  @override
  Future<Either<String, Response>> call(
      {required CreatePassReqParams param}) async {
    return await authRepository.createPassword(param);
  }
}
