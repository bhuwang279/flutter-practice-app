import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recharge_app/core/network/graphql_conf.dart';
import 'package:recharge_app/core/errors/exception.dart';

import 'package:recharge_app/features/login/data/datasources/login_remote_data_source.dart';
import 'package:matcher/matcher.dart';
import 'package:recharge_app/features/login/data/models/login_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGraphQLClient extends Mock implements CustomGraphQLClient {}

void main() {
  LoginRemoteDataSourceImpl dataSource;
  MockGraphQLClient mockGraphQLClient;

  setUp(() {
    mockGraphQLClient = MockGraphQLClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockGraphQLClient);
  });
  void setUpSuccessfulMutationResponse(){
    when(mockGraphQLClient.mutateUnauth(any)).thenAnswer((_) async 
      => Future.value(fixture('create_token_Response.json')));
  }
  group('createTokenMutation', () {
    final tMobileNumber = 'akbarykhan@gmail.com';
    final tPassword = 'Lokman@279';
    final tLoginModel = LoginModel.fromJson(json.decode(fixture('create_token_Response.json')));
    
    
    test(
      'should perform a createToken Mutation',
      () async {
        
        // arrange
        setUpSuccessfulMutationResponse();
        
        // act
        await dataSource.getMobileNumberAndToken(tMobileNumber, tPassword);
        // assert
        
        verify(mockGraphQLClient.mutateUnauth(any));
      },
    );

    test(
      'should return Login Model when response code is 200',
      () async {
        
        // arrange
        setUpSuccessfulMutationResponse();

        // act
        final result = await dataSource.getMobileNumberAndToken(tMobileNumber, tPassword);
        
        // assert
        expect(result, equals(tLoginModel));
      },
    );
    test(
      'should return server exception when response code is 400 or server error',
      () async {
        
        // arrange
        when(mockGraphQLClient.mutateUnauth(any)).thenThrow(ServerException());
        // act
        final call = dataSource.getMobileNumberAndToken;
        // assert
        
        expect(() => call(tMobileNumber, tPassword),
            throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
