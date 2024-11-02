import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/repository/auth_repository_imp.dart';
import 'package:challange_beclever/features/auth/data/source/auth_api_service.dart';
import 'package:challange_beclever/features/auth/data/source/auth_local_service.dart';
import 'package:challange_beclever/features/auth/domain/repository/auth.dart';
import 'package:challange_beclever/features/auth/domain/usecases/validate_phone_case.dart';
import 'package:challange_beclever/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
void setupServiceLocator() {
  // Core & External
  sl.registerSingleton<DioClientFake>(const DioClientFake());

  // Register SharedPreferences asynchronously
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  // Services
  sl.registerSingletonWithDependencies<AuthApiService>(
    () => AuthApiServiceImpl(
      network: sl<DioClientFake>(),
      prefs: sl<SharedPreferences>(),
    ),
    dependsOn: [SharedPreferences],
  );

  sl.registerSingletonWithDependencies<AuthLocalService>(
    () => AuthLocalServiceImpl(
      sharedPreferences: sl<SharedPreferences>(),
    ),
    dependsOn: [SharedPreferences],
  );

  // Repositories
  sl.registerSingletonWithDependencies<AuthRepository>(
    () => AuthRepositoryImpl(
      authApiService: sl<AuthApiService>(),
      authLocalService: sl<AuthLocalService>(),
    ),
    dependsOn: [AuthApiService, AuthLocalService],
  );

  // Use Cases
  sl.registerSingletonWithDependencies<ValidatePhoneCase>(
    () => ValidatePhoneCase(
      authRepository: sl<AuthRepository>(),
    ),
    dependsOn: [AuthRepository],
  );

  // Blocs
  sl.registerSingletonWithDependencies<AuthenticationBloc>(
    () => AuthenticationBloc(
      validatePhoneCase: sl<ValidatePhoneCase>(),
    ),
    dependsOn: [ValidatePhoneCase],
  );
}
