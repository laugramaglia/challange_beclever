import 'package:challange_beclever/core/config/bloc/service_locator.dart';
import 'package:challange_beclever/core/usecase/usecase.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}
