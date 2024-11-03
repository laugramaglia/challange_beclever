import 'package:challange_beclever/features/auth/data/models/log_in_req_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogInReqParams', () {
    // Datos de prueba
    const testCedula = '1234567890';
    const testPassword = 'SecurePass123!';

    test('should create LogInReqParams instance with correct values', () {
      // Arrange & Act
      final params = LogInReqParams(
        cedula: testCedula,
        password: testPassword,
      );

      // Assert
      expect(params.cedula, equals(testCedula));
      expect(params.password, equals(testPassword));
    });

    group('toMap', () {
      test('should return correct map with all fields', () {
        // Arrange
        final params = LogInReqParams(
          cedula: testCedula,
          password: testPassword,
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'cedula': testCedula,
              'password': testPassword,
            }));
      });

      test('should preserve empty strings in map', () {
        // Arrange
        final params = LogInReqParams(
          cedula: '',
          password: '',
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'cedula': '',
              'password': '',
            }));
      });

      test('should preserve whitespace in map values', () {
        // Arrange
        final params = LogInReqParams(
          cedula: '  $testCedula  ',
          password: '  $testPassword  ',
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'cedula': '  $testCedula  ',
              'password': '  $testPassword  ',
            }));
      });
    });

    group('edge cases', () {
      test('should handle very long strings', () {
        // Arrange
        final longString = 'a' * 1000;
        final params = LogInReqParams(
          cedula: longString,
          password: longString,
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(map['cedula'], equals(longString));
        expect(map['password'], equals(longString));
      });

      test('should handle special characters', () {
        // Arrange
        const specialChars = '!@#\$%^&*()_+-=[]{}|;:,.<>?/~`';
        final params = LogInReqParams(
          cedula: specialChars,
          password: specialChars,
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(map['cedula'], equals(specialChars));
        expect(map['password'], equals(specialChars));
      });

      test('should handle unicode characters', () {
        // Arrange
        const unicodeString = '🔑👤äéíóúñ';
        final params = LogInReqParams(
          cedula: unicodeString,
          password: unicodeString,
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(map['cedula'], equals(unicodeString));
        expect(map['password'], equals(unicodeString));
      });
    });

    group('type verification', () {
      test('map values should be strings', () {
        // Arrange
        final params = LogInReqParams(
          cedula: testCedula,
          password: testPassword,
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(map['cedula'], isA<String>());
        expect(map['password'], isA<String>());
      });
    });
  });
}
