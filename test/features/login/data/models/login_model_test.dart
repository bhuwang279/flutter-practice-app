import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recharge_app/features/login/data/models/login_model.dart';

import '../../../../fixtures/fixture_reader.dart';
void main() {
  final tloginModel = LoginModel(mobileNumber: 'akbarykhan@gmail.com', token: 'somerandomtoken');

  test(
    'should be a subclass of LoginModel entity',
    () async {
      // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('create_token_Response.json'));
        // act
        final result = LoginModel.fromJson(jsonMap);
        // assert
        expect(result, tloginModel);
    },
  );
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tloginModel.toJson();
        // assert
        final expectedMap = {
          "mobileNumber": "akbarykhan@gmail.com",
          "token": 'somerandomtoken',
        };
        expect(result, expectedMap);
      },
    );
  });
}