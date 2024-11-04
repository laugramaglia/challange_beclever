import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/models/create_pass_req_params.dart';
import 'package:challange_beclever/features/auth/data/models/log_in_req_params.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/data/repository/auth_repository_imp.dart';
import 'package:challange_beclever/features/auth/data/source/auth_api_service.dart';
import 'package:challange_beclever/features/auth/data/source/auth_local_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_repository_imp_test.mocks.dart';

@GenerateMocks([AuthApiService, SharedPreferences, LocalAuthentication])
void main() {
  late MockAuthApiService mockAuthApiService;
  late AuthRepositoryImpl authRepository;
  late MockSharedPreferences mockSharedPreferences;
  late AuthLocalServiceImpl authLocalServiceImpl;
  late MockLocalAuthentication localAuth;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    authLocalServiceImpl =
        AuthLocalServiceImpl(sharedPreferences: mockSharedPreferences);
    mockAuthApiService = MockAuthApiService();
    localAuth = MockLocalAuthentication();
    authRepository = AuthRepositoryImpl(
      authLocalService: authLocalServiceImpl,
      authApiService: mockAuthApiService,
      localAuth: localAuth,
    );
  });

  group('validatePhone', () {
    final param = ValidatePhoneReqParams(
      phoneNumber: '+573001234567',
      code: '123456',
      cedula: '1234567890',
    );

    final response = Response(
      data: {
        "message": "Success",
        'token': 'bearer-token',
        'value': {
          'id': '1',
          'cedula': '1234567890',
          'phoneNumber': '01234567',
        }
      },
      statusCode: 201,
    );

    test('should clear token on error', () async {
      // Arrange
      when(mockAuthApiService.validatePhone(param))
          .thenAnswer((_) async => const Left('error'));
      when(mockSharedPreferences.containsKey('token')).thenReturn(true);
      when(mockSharedPreferences.remove('token')).thenAnswer((_) async => true);

      // Act
      final result = await authRepository.validatePhone(param);

      // Assert
      expect(result, const Left('error'));
      verify(authLocalServiceImpl.clearToken()).called(1);
    });

    test('should set token on successful response', () async {
      // Arrange
      when(mockAuthApiService.validatePhone(param))
          .thenAnswer((_) async => Right(response));
      when(mockSharedPreferences.setString('token', 'bearer-token'))
          .thenAnswer((_) async => true);

      // Act
      final result = await authRepository.validatePhone(param);

      // Assert
      expect(result, Right(response));
      verify(authLocalServiceImpl.setToken('bearer-token')).called(1);
    });
  });

  group('logIn', () {
    final param = LogInReqParams(
      password: '1234567890',
      cedula: '1234567890',
    );

    final response = Response(
      data: {
        "message": "Success",
        'token': 'bearer-token',
        'value': {
          'id': '1',
          'cedula': '1234567890',
          'phoneNumber': '01234567',
        }
      },
      statusCode: 201,
    );

    test('should return error when login fails', () async {
      // Arrange
      when(mockAuthApiService.login(params: param.toMap()))
          .thenAnswer((_) async => const Left('login error'));

      // Act
      final result = await authRepository.logIn(param);

      // Assert
      expect(result, const Left('login error'));
    });

    test('should set token on successful login', () async {
      // Arrange
      when(mockAuthApiService.login(params: param.toMap()))
          .thenAnswer((_) async => Right(response));
      when(mockSharedPreferences.setString('token', 'bearer-token'))
          .thenAnswer((_) async => true);

      // Act
      final result = await authRepository.logIn(param);

      // Assert
      expect(result, Right(response));
      verify(authLocalServiceImpl.setToken('bearer-token')).called(1);
    });
  });

  group('getUser', () {
    test('should return user data from authApiService', () async {
      // Arrange
      final userResponse =
          Response(data: {'user': 'dummy_user'}, statusCode: 200);
      when(mockAuthApiService.getUser())
          .thenAnswer((_) async => Right(userResponse));

      // Act
      final result = await authRepository.getUser();

      // Assert
      expect(result, Right(userResponse));
      verify(mockAuthApiService.getUser()).called(1);
    });
  });

  group('createPassword', () {
    final CreatePassReqParams params = CreatePassReqParams(
      useBiometric: false,
      password: '1234567890',
    );

    test('should return response from createPassword', () async {
      // Arrange
      final passwordResponse =
          Response(data: {'message': 'Success'}, statusCode: 201);
      when(mockAuthApiService.createPassword(params))
          .thenAnswer((_) async => Right(passwordResponse));

      // Act
      final result = await authRepository.createPassword(params);

      // Assert
      expect(result, Right(passwordResponse));
      verify(mockAuthApiService.createPassword(params)).called(1);
    });
  });
}
