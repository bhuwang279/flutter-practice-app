import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:recharge_app/core/constants.dart';
import 'package:recharge_app/core/errors/failures.dart';
import 'package:recharge_app/core/utils/validators.dart';
import 'package:recharge_app/features/login/domain/entities/login.dart';
import 'package:recharge_app/features/login/domain/usecases/get_mobile_number_and_token.dart';
import 'package:recharge_app/features/login/presentation/bloc/bloc.dart';
import 'package:recharge_app/features/login/presentation/bloc/login_bloc.dart';

class MockGetMobileNumberAndToken extends Mock
    implements GetMobileNumberAndToken {}

class MockValidator extends Mock implements Validator {}

void main() {
  MockGetMobileNumberAndToken mockGetMobileNumberAndToken;
  MockValidator mockValidator;
  LoginBloc loginBloc;

  final tMobileNumber = '77880794';
  final tPassword = 'P@ssw0rd';
  final tMobileNumberLength = MOBILE_NUMBER_LENGTH;
  final tPasswordLength = MINIMUM_PASSWORD_LENGTH;
  final tLogin = Login(mobileNumber: '778807894', token: 'somerandomtoken');

  setUp(() {
    mockGetMobileNumberAndToken = MockGetMobileNumberAndToken();
    mockValidator = MockValidator();
    loginBloc = LoginBloc(
        getMobileNumberAndToken: mockGetMobileNumberAndToken,
        validator: mockValidator);
  });

  void setUpSuccessValidation(){
    when(mockValidator.validateMobileNumberAndPassword(any, any, any, any))
          .thenReturn(Right(true));
  }

  test('Initial State Should be LoginInitial', () {
    expect(loginBloc.initialState, equals(LoginInitial()));
  });

  group('GetMobileNumberAndToken', () {
    test('should call validate mobile number and password', () async {
      //arrange
      setUpSuccessValidation();
      //act

      loginBloc.add(
          LoginButtonPressed(mobileNumber: tMobileNumber, password: tPassword));

      await untilCalled(
          mockValidator.validateMobileNumberAndPassword(any, any, any, any));
      //assert
      verify(mockValidator.validateMobileNumberAndPassword(
          tMobileNumber, tMobileNumberLength, tPassword, tPasswordLength));
    });

    test('should emit [Error] when mobile numnber is invalid', () async {
      final expected = [
        LoginInitial(),
        LoginFailure(error: INVALID_MOBILE_NUMBER_MESSAGE)
      ];

      //arrange

      when(mockValidator.validateMobileNumberAndPassword(any, any, any, any))
          .thenReturn(
              Left(ValidatorFailure(message: INVALID_MOBILE_NUMBER_MESSAGE)));

      //assert later
      expectLater(loginBloc, emitsInOrder(expected));
      //act

      loginBloc.add(
          LoginButtonPressed(mobileNumber: tMobileNumber, password: tPassword));
    });

    test('should emit [Error] when password is invalid', () async {
      final expected = [
        LoginInitial(),
        LoginFailure(error: INVALID_PASSWORD_MESSAGE)
      ];

      //arrange
      when(mockValidator.validateMobileNumberAndPassword(any, any, any, any))
          .thenReturn(
              Left(ValidatorFailure(message: INVALID_PASSWORD_MESSAGE)));

      //assert later
      expectLater(loginBloc, emitsInOrder(expected));
      //act

      loginBloc.add(
          LoginButtonPressed(mobileNumber: tMobileNumber, password: tPassword));
    });

    test('should get data from GetMobileNumberAndToken usecase', () async {
      setUpSuccessValidation();
      when(mockGetMobileNumberAndToken(any))
          .thenAnswer((_) async => Right(tLogin));

      loginBloc.add(
          LoginButtonPressed(mobileNumber: tMobileNumber, password: tPassword));

      await untilCalled(mockGetMobileNumberAndToken(any));
      verify(mockGetMobileNumberAndToken(
          Params(mobileNumber: tMobileNumber, password: tPassword)));
    });

    test('Should emit [LoginInitial, LoginLoading, Loggedin] when data is gotten successfully', (){
      //arrange
      setUpSuccessValidation();
      when(mockGetMobileNumberAndToken(any)).thenAnswer((_) async => Right(tLogin));

      //assert later
      final expected = [
        LoginInitial(),
        LoginLoading(),
        LoggedIn(login: tLogin),
      ];

      expectLater(loginBloc, emitsInOrder(expected));

      //act

      loginBloc.add(LoginButtonPressed(mobileNumber: tMobileNumber, password: tPassword));
    });

    test('Should emit [LoginInitial, LoginLoading, LoginFailure] when getting data fails', (){
      setUpSuccessValidation();
      when(mockGetMobileNumberAndToken(any)).thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      final expected = [
        LoginInitial(),
        LoginLoading(),
        LoginFailure(error: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(loginBloc, emitsInOrder(expected));

      //act

      loginBloc.add(LoginButtonPressed(mobileNumber: tMobileNumber, password: tPassword));
    });

    test('Should emit [LoginInitial, LoginLoading, LoginFailure] when caching fails', (){
      setUpSuccessValidation();
      when(mockGetMobileNumberAndToken(any)).thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      final expected = [
        LoginInitial(),
        LoginLoading(),
        LoginFailure(error: CACHE_FAILURE_MESSAGE)
      ];

      expectLater(loginBloc, emitsInOrder(expected));

      //act

      loginBloc.add(LoginButtonPressed(mobileNumber: tMobileNumber, password: tPassword));
    });

  });
}
