import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/repository/auth_repository_imp.dart';
import 'package:challange_beclever/features/auth/data/source/auth_api_service.dart';
import 'package:challange_beclever/features/auth/data/source/auth_local_service.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';
import 'package:challange_beclever/features/auth/domain/usecases/create_password_use_case.dart';
import 'package:challange_beclever/features/auth/domain/usecases/logout.dart';
import 'package:challange_beclever/features/auth/domain/usecases/validate_phone_case.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
void setupServiceLocator() {
  // Core

  // Registros síncronos
  sl.registerSingleton<DioClientFake>(const DioClientFake());

  sl.registerSingleton<AuthApiService>(
    AuthApiServiceImpl(
      network: sl<DioClientFake>(),
    ),
  );

  // Registros asíncronos
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  sl.registerSingletonAsync<AuthLocalService>(() async {
    final prefs = await sl.getAsync<SharedPreferences>();
    return AuthLocalServiceImpl(
      sharedPreferences: prefs,
    );
  });

  // Repositories
  sl.registerSingletonWithDependencies<AuthRepository>(
    () => AuthRepositoryImpl(
      authApiService: sl<AuthApiService>(),
      authLocalService: sl<AuthLocalService>(),
    ),
    dependsOn: [AuthLocalService],
  );

  // Use Cases
  sl.registerSingletonWithDependencies<ValidatePhoneCase>(
    () => ValidatePhoneCase(
      authRepository: sl<AuthRepository>(),
    ),
    dependsOn: [AuthRepository],
  );

  sl.registerSingletonWithDependencies<LogoutUseCase>(
    () => LogoutUseCase(
      authRepository: sl<AuthRepository>(),
    ),
    dependsOn: [AuthRepository],
  );

  sl.registerSingletonWithDependencies<CreatePasswordUseCase>(
    () => CreatePasswordUseCase(
      authRepository: sl<AuthRepository>(),
    ),
    dependsOn: [AuthRepository],
  );

  // Blocs
  sl.registerSingletonWithDependencies<AuthenticationBloc>(
    () => AuthenticationBloc(
      validatePhoneCase: sl<ValidatePhoneCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      createPasswordUseCase: sl<CreatePasswordUseCase>(),
    ),
    dependsOn: [ValidatePhoneCase, LogoutUseCase],
  );
}
