import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:recharge_app/core/network/graphql_conf.dart';
import 'package:recharge_app/core/errors/exception.dart';
import 'package:recharge_app/features/login/data/graphql/mutations.dart';
import 'package:recharge_app/features/login/data/models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> getMobileNumberAndToken(
      String mobileNumber, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final CustomGraphQLClient client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<LoginModel> getMobileNumberAndToken(
      String mobileNumber, String password) async {

    final MutationOptions options = MutationOptions(
      document: createTokenMutation(mobileNumber, password),
    );
    try {
      final result = await client.mutateUnauth(options);

      return LoginModel.fromJson(json.decode(result));

    } on ServerException {

      throw ServerException();

    }
  }
}
