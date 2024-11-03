// Generate a mock class for SharedPreferences
import 'package:challange_beclever/features/auth/data/source/auth_local_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_local_service_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AuthLocalServiceImpl authLocalServiceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    authLocalServiceImpl =
        AuthLocalServiceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('AuthLocalServiceImpl', () {
    test('should return token if it exists in SharedPreferences', () {
      // Arrange
      when(mockSharedPreferences.getString('token')).thenReturn('dummy_token');

      // Act
      final token = authLocalServiceImpl.getToken();

      // Assert
      expect(token, 'dummy_token');
      verify(mockSharedPreferences.getString('token')).called(1);
    });

    test('should save token to SharedPreferences', () async {
      // Arrange
      when(mockSharedPreferences.setString('token', 'dummy_token'))
          .thenAnswer((_) async => true);

      // Act
      final result = await authLocalServiceImpl.setToken('dummy_token');

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.setString('token', 'dummy_token')).called(1);
    });

    test('should clear token from SharedPreferences if it exists', () async {
      // Arrange
      when(mockSharedPreferences.containsKey('token')).thenReturn(true);
      when(mockSharedPreferences.remove('token')).thenAnswer((_) async => true);

      // Act
      final result = await authLocalServiceImpl.clearToken();

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.containsKey('token')).called(1);
      verify(mockSharedPreferences.remove('token')).called(1);
    });

    test('should return null if no token to clear', () async {
      // Arrange
      when(mockSharedPreferences.containsKey('token')).thenReturn(false);

      // Act
      final result = await authLocalServiceImpl.clearToken();

      // Assert
      expect(result, null);
      verify(mockSharedPreferences.containsKey('token')).called(1);
      verifyNever(mockSharedPreferences.remove('token'));
    });

    test('should clear all data from SharedPreferences on logout', () async {
      // Arrange
      when(mockSharedPreferences.clear()).thenAnswer((_) async => true);

      // Act
      await authLocalServiceImpl.logout();

      // Assert
      verify(mockSharedPreferences.clear()).called(1);
    });
  });
}
