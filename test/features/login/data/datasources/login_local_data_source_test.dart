import 'dart:convert';

import 'package:recharge_app/core/errors/exception.dart';
import 'package:recharge_app/features/login/data/models/login_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recharge_app/features/login/data/datasources/login_local_data_scource.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  LoginLocalDataScourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LoginLocalDataScourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getCachedCredentails', () {
  final tLoginModel =
      LoginModel.fromJson(json.decode(fixture('create_token_Response.json')));

  test(
    'should return cached credentials from SharedPreferences when there is one in the cache',
    () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('create_token_Response.json'));
      // act
      final result = await dataSource.getLastCachedMobileNumberAndToken();
      // assert
      verify(mockSharedPreferences.getString('CACHED_CREDENTIALS'));
      expect(result, equals(tLoginModel));
    },
  );

  test('should throw a CacheException when there is not a cached value', () {
  // arrange
    when(mockSharedPreferences.getString(any)).thenReturn(null);
    // act
    // Not calling the method here, just storing it inside a call variable
    final call = dataSource.getLastCachedMobileNumberAndToken;
    // assert
    // Calling the method happens from a higher-order function passed.
    // This is needed to test if calling a method throws an exception.
    expect(() => call(), throwsA(TypeMatcher<CacheException>()));
  });

  group('cacheCredentials', () {
  final tLoginModel =
      LoginModel(mobileNumber: '7788079', token: 'somerandomtext');

  test('should call SharedPreferences to cache the data', () {
    // act
    dataSource.cacheMobileNumberAndToken(tLoginModel);
    // assert
    final expectedJsonString = json.encode(tLoginModel.toJson());
    verify(mockSharedPreferences.setString(
      CACHED_CREDENTIALS,
      expectedJsonString,
    ));
  });
});
});
}