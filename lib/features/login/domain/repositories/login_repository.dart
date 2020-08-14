import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> getMobileNumberAndToken(String mobileNumber, String password);
 
}