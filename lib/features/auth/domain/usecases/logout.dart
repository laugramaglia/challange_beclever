import 'package:challange_beclever/core/usecase/usecase.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';

class LogoutUseCase implements UseCase<void, dynamic> {
  final AuthRepository authRepository;
  const LogoutUseCase({required this.authRepository});
  @override
  Future<void> call({param}) async {
    return await authRepository.logOut();
  }
}
