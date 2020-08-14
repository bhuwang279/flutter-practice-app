import 'package:dartz/dartz.dart';
import 'package:recharge_app/features/login/domain/entities/login.dart';
import 'package:recharge_app/features/login/domain/repositories/login_repository.dart';
import 'package:recharge_app/features/login/domain/usecases/get_mobile_number_and_token.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock
    implements LoginRepository {}

void main() {
  GetMobileNumberAndToken usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = GetMobileNumberAndToken(mockLoginRepository);
  });
  final tMobileNumber = '77880794';
  final tPassword = 'P@ssw0rd';
  final tLogin = Login(mobileNumber: tMobileNumber, token: 'somerandomcharacters');

  test(
    'should get trivia for the number from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getEmailAndToken is called with any argument, always answer with
      // the Right "side" of Either containing a test Login object.
      when(mockLoginRepository.getMobileNumberAndToken(any,any))
          .thenAnswer((_) async => Right(tLogin));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase(Params(mobileNumber: tMobileNumber, password: tPassword));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tLogin));
      // Verify that the method has been called on the Repository
      verify(mockLoginRepository.getMobileNumberAndToken(tMobileNumber, tPassword));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );
}