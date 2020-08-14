import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recharge_app/core/constants.dart';
import 'package:recharge_app/core/utils/validators.dart';

void main() {
  Validator validator;

  setUp(() {
    validator = Validator();
  });

  group('MobileNumberValidator', () {
    final tLength = MOBILE_NUMBER_LENGTH;
    test(
        'Should return failure when mobile number is not equal to valid length',
        () {
      final tMobileNumber = '7788';

      final result = validator.validateMobileNumber(tMobileNumber, tLength);

      expect(result,
          Left(ValidatorFailure(message: INVALID_MOBILE_NUMBER_MESSAGE)));
    });

    test('should return true when mobile number is equal to valid length', () {
      final tMobileNumber = '77880794';

      final result = validator.validateMobileNumber(tMobileNumber, tLength);

      expect(result, Right(true));
    });
  });

  group('PasswordValidator', () {
    final tLength = MINIMUM_PASSWORD_LENGTH;
    test('Should return failure when password is less then valid length', () {
      final tPassword = 'pass';

      final result = validator.validatePassword(tPassword, tLength);

      expect(result,
          Left(ValidatorFailure(message: INVALID_PASSWORD_MESSAGE)));
    });

    test('should return true when input is greater than or equal to valid length', () {
      final tPassword = 'P@ssw0rd';

      final result = validator.validatePassword(tPassword, tLength);

      expect(result, Right(true));
    });
  });
}
