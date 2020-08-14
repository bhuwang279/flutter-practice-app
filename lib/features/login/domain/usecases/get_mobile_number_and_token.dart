import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../features/login/domain/entities/login.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/login_repository.dart';

class GetMobileNumberAndToken extends UseCase <Login, Params>{
  final LoginRepository repository;

  GetMobileNumberAndToken(this.repository);
  Future<Either<Failure, Login>> call(
    Params params
  ) async {
    return await repository.getMobileNumberAndToken(params.mobileNumber, params.password);
  }
}

class Params extends Equatable {
  final String mobileNumber;
  final String password;

  Params({@required this.mobileNumber, @required this.password});

  @override

  List<Object> get props => [mobileNumber, password];
}