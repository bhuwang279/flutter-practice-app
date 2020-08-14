import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/login.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_scource.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataScource localDataScource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataScource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, Login>> getMobileNumberAndToken(
      String mobileNumber, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final loginModel = await remoteDataSource.getMobileNumberAndToken(
            mobileNumber, password);
        localDataScource.cacheMobileNumberAndToken(loginModel);
        return Right(loginModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
