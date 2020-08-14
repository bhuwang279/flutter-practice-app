import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recharge_app/core/utils/input_converter.dart';

void main(){
  InputConverter inputConverter;

  setUp((){
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', (){
    
    test('should return an integer when the string represents an unsigned integer', () async {

      final str = '123';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Right(123));
    });

    test('should return a failure when string is not integer', () async {

      final str = 'asf';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });

     test('should return a failure when string is negetive nteger', () async {

      final str = '-123';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}