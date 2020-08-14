import 'package:dartz/dartz.dart';
import 'package:recharge_app/core/constants.dart';
import 'package:recharge_app/core/errors/failures.dart';
import 'package:meta/meta.dart';

class Validator {

  Either <Failure, bool> validateMobileNumber(String mobileNumber, int length){
    
    if(mobileNumber.length != length) {
      return Left(ValidatorFailure(message: INVALID_MOBILE_NUMBER_MESSAGE));
    } else{
      return Right(true);
    }
  }

   Either <Failure, bool> validatePassword(String password, int length){
    
    if(password.length < length) {
      return Left(ValidatorFailure(message: INVALID_PASSWORD_MESSAGE));
    } else{
      return Right(true);
    }
  }

  Either<Failure, bool> validateMobileNumberAndPassword(String mobileNumber, int mobileNumberLength, String password, int passwordLength){

    if(mobileNumber.length != mobileNumberLength){
      return Left(ValidatorFailure(message: INVALID_MOBILE_NUMBER_MESSAGE));
    }else if(password.length < passwordLength)  {
      return Left(ValidatorFailure(message: INVALID_PASSWORD_MESSAGE));
    }else{
      return Right(true);
    }
  }
  
}

class ValidatorFailure extends Failure {
  final String message;
  ValidatorFailure({@required this.message});

  @override
  String toString(){
    return this.message;
  }

}