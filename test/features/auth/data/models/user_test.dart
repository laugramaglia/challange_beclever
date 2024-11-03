import 'package:challange_beclever/features/auth/data/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:challange_beclever/features/auth/domain/entities/user.dart';

void main() {
  // Datos de prueba
  const testPhoneNumber = '+573001234567';
  const testId = 'test-id-123';
  const testCedula = '1234567890';

  final testMap = {
    'phoneNumber': testPhoneNumber,
    'id': testId,
    'cedula': testCedula,
  };

  group('UserModel', () {
    test('should create UserModel instance with correct values', () {
      // Arrange & Act
      final userModel = UserModel(
        phoneNumber: testPhoneNumber,
        id: testId,
        cedula: testCedula,
      );

      // Assert
      expect(userModel.phoneNumber, equals(testPhoneNumber));
      expect(userModel.id, equals(testId));
      expect(userModel.cedula, equals(testCedula));
    });

    test('fromMap should create UserModel from Map with correct values', () {
      // Act
      final userModel = UserModel.fromMap(testMap);

      // Assert
      expect(userModel.phoneNumber, equals(testPhoneNumber));
      expect(userModel.id, equals(testId));
      expect(userModel.cedula, equals(testCedula));
    });

    test('props should contain phoneNumber and id', () {
      // Arrange
      final userModel = UserModel(
        phoneNumber: testPhoneNumber,
        id: testId,
        cedula: testCedula,
      );

      // Act & Assert
      expect(userModel.props, equals([testPhoneNumber, testId]));
    });

    test('stringify should return true', () {
      // Arrange
      final userModel = UserModel(
        phoneNumber: testPhoneNumber,
        id: testId,
        cedula: testCedula,
      );

      // Act & Assert
      expect(userModel.stringify, isTrue);
    });
  });

  group('UserXModel Extension', () {
    test('toEntity should return User with correct values', () {
      // Arrange
      final userModel = UserModel(
        phoneNumber: testPhoneNumber,
        id: testId,
        cedula: testCedula,
      );

      // Act
      final user = userModel.toEntity();

      // Assert
      expect(user, isA<User>());
      expect(user.phoneNumber, equals(testPhoneNumber));
      expect(user.id, equals(testId));
      expect(user.cedula, equals(testCedula));
    });

    test('toMap should return correct Map representation', () {
      // Arrange
      final userModel = UserModel(
        phoneNumber: testPhoneNumber,
        id: testId,
        cedula: testCedula,
      );

      // Act
      final map = userModel.toMap();

      // Assert
      expect(map, equals(testMap));
    });

    test('fromMap should throw when map values are not String', () {
      // Arrange
      final invalidMap = {
        'phoneNumber': 123, // Invalid type (should be String)
        'id': testId,
        'cedula': testCedula,
      };

      // Act & Assert
      expect(
        () => UserModel.fromMap(invalidMap),
        throwsA(isA<TypeError>()),
      );
    });

    test('fromMap should throw when required fields are missing', () {
      // Arrange
      final incompleteMap = {
        'phoneNumber': testPhoneNumber,
        // 'id' is missing
        'cedula': testCedula,
      };

      // Act & Assert
      expect(
        () => UserModel.fromMap(incompleteMap),
        throwsA(
            anything), // Podría ser TypeError o otra excepción dependiendo de tu implementación
      );
    });
  });
}
