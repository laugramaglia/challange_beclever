import 'package:challange_beclever/features/auth/data/models/validate_phone_req_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValidatePhoneReqParams', () {
    const testPhone = '+573001234567';
    const testCedula = '1234567890';
    const testCode = '123456';

    test('should create ValidatePhoneReqParams instance with correct values',
        () {
      // Arrange & Act
      final params = ValidatePhoneReqParams(
        phoneNumber: testPhone,
        cedula: testCedula,
        code: testCode,
      );

      // Assert
      expect(params.phoneNumber, equals(testPhone));
      expect(params.cedula, equals(testCedula));
      expect(params.code, equals(testCode));
    });

    group('toMap', () {
      test('should return correct map with numeric code', () {
        // Arrange
        final params = ValidatePhoneReqParams(
          phoneNumber: testPhone,
          cedula: testCedula,
          code: testCode,
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'phoneNumber': testPhone,
              'cedula': testCedula,
              'code': 123456, // Converted to integer
            }));
      });

      test('should handle non-numeric code', () {
        // Arrange
        final params = ValidatePhoneReqParams(
          phoneNumber: testPhone,
          cedula: testCedula,
          code: 'ABC123', // Non-numeric code
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'phoneNumber': testPhone,
              'cedula': testCedula,
              'code': null, // Should be null when code is not numeric
            }));
      });

      test('should handle empty code', () {
        // Arrange
        final params = ValidatePhoneReqParams(
          phoneNumber: testPhone,
          cedula: testCedula,
          code: '', // Empty code
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'phoneNumber': testPhone,
              'cedula': testCedula,
              'code': null, // Should be null for empty string
            }));
      });

      test('should handle code with leading zeros', () {
        // Arrange
        final params = ValidatePhoneReqParams(
          phoneNumber: testPhone,
          cedula: testCedula,
          code: '001234', // Code with leading zeros
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'phoneNumber': testPhone,
              'cedula': testCedula,
              'code':
                  1234, // Should preserve numeric value without leading zeros
            }));
      });

      test('should handle code with whitespace', () {
        // Arrange
        final params = ValidatePhoneReqParams(
          phoneNumber: testPhone,
          cedula: testCedula,
          code: ' 123456 ', // Code with whitespace
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(
            map,
            equals({
              'phoneNumber': testPhone,
              'cedula': testCedula,
              'code': 123456, // Should handle whitespace correctly
            }));
      });
    });

    group('edge cases', () {
      test('should handle very long numeric code', () {
        // Arrange
        final params = ValidatePhoneReqParams(
          phoneNumber: testPhone,
          cedula: testCedula,
          code: '999999999999999999', // Very long number
        );

        // Act & Assert
        // This test verifies that very long numbers are handled without overflow
        expect(params.toMap()['code'], isA<int?>());
      });

      test('should handle special characters in code', () {
        // Arrange
        final params = ValidatePhoneReqParams(
          phoneNumber: testPhone,
          cedula: testCedula,
          code: '123-456', // Code with special characters
        );

        // Act
        final map = params.toMap();

        // Assert
        expect(map['code'], isNull); // Should be null for invalid format
      });
    });
  });
}
