import 'package:challange_beclever/core/network/dio_client_fake.dart';
import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:challange_beclever/features/auth/data/source/auth_api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_api_service_test.mocks.dart';

@GenerateMocks([DioClientFake])
void main() {
  late MockDioClientFake mockNetwork;
  late AuthApiServiceImpl authApiService;
  setUp(() {
    mockNetwork = MockDioClientFake();
    authApiService = AuthApiServiceImpl(network: mockNetwork);
  });
  group('validatePhone group', () {
    late final ValidatePhoneReqParams params;
    late final Response successResponse;
    setUp(() {
      params = ValidatePhoneReqParams(
        phoneNumber: '1234567',
        code: '993456',
        cedula: '80925632',
      );
      successResponse = Response(
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
    });

    test('validatePhone returns Right when status code is 201', () async {
      // Mocking the network response
      when(mockNetwork.post('/validate-phone', data: params.toMap()))
          .thenAnswer((_) async => successResponse);

      final result = await authApiService.validatePhone(params);
      final right = result.fold((l) => null, (r) => r);

      expect(result, isA<Right>());
      expect(right?.statusCode, 201);
    });

    test('validatePhone returns Left with error message on failure', () async {
      final errorResponse = Response(
        statusCode: 400,
        data: {'message': 'Invalid phone number'},
      );

      when(mockNetwork.post('/validate-phone', data: params.toMap()))
          .thenAnswer((_) async => errorResponse);

      final result = await authApiService.validatePhone(params);

      expect(result, isA<Left>());
      expect(result.fold((l) => l, (_) => ''), 'Invalid phone number');
    });
  });
}
