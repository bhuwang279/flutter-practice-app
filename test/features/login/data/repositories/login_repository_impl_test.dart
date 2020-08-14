import 'package:dartz/dartz.dart';
import 'package:recharge_app/core/errors/exception.dart';
import 'package:recharge_app/core/network/network_info.dart';
import 'package:recharge_app/features/login/data/datasources/login_local_data_scource.dart';
import 'package:recharge_app/features/login/data/datasources/login_remote_data_source.dart';
import 'package:recharge_app/features/login/data/models/login_model.dart';
import 'package:recharge_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:recharge_app/features/login/domain/entities/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:recharge_app/core/errors/failures.dart';

class MockLoginRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockLoginLocalDataScource extends Mock implements LoginLocalDataScource {}

class MockNetworkInfo extends Mock implements NetworkInfo{}

main() {
  LoginRepositoryImpl repository;
  MockLoginRemoteDataSource mockRemoteDataSource;
  MockLoginLocalDataScource mockLoginLocalDataScource;
  MockNetworkInfo mockNetworkInfo;


  setUp((){
    mockRemoteDataSource = MockLoginRemoteDataSource();
    mockLoginLocalDataScource = MockLoginLocalDataScource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl( remoteDataSource: mockRemoteDataSource,localDataScource: mockLoginLocalDataScource, networkInfo: mockNetworkInfo);
  });

  group('getMobileNumberAndToken', (){
      final tMobileNumber = '77880794';
      final tPassword = 'P@ssw0rd';
      final tToken = 'somerandomtexrt';
      final tLoginModel = LoginModel(mobileNumber: tMobileNumber, token: tToken);
      final Login tLogin = tLoginModel;
      test('should check if device is online', (){
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        //act
        repository.getMobileNumberAndToken(tMobileNumber, tPassword);

        //assert

        verify(mockNetworkInfo.isConnected);
      });

      group('device is online', (){
        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        test(
          'should return remote data when the call to remote data source is successful',
          () async {
            // arrange
            when(mockRemoteDataSource.getMobileNumberAndToken(any, any))
                .thenAnswer((_) async => tLoginModel);
            // act
            final result = await repository.getMobileNumberAndToken(tMobileNumber, tPassword);
    
            // assert
            verify(mockRemoteDataSource.getMobileNumberAndToken(tMobileNumber, tPassword));
            expect(result, equals(Right(tLogin)));
          },
        );

        test(
          'should cache data locally when call to remote data source is successfull',
          () async {
            // arrange
            when(mockRemoteDataSource.getMobileNumberAndToken(any, any))
                .thenAnswer((_) async => tLoginModel);
            // act
            await repository.getMobileNumberAndToken(tMobileNumber, tPassword);
            // assert
            verify(mockRemoteDataSource.getMobileNumberAndToken(tMobileNumber, tPassword));
            verify(mockLoginLocalDataScource.cacheMobileNumberAndToken(tLoginModel));
            
          },
        );

        test(
          'should return server failure  when the call to remote data source is unsuccessful',
          () async {
            // arrange
            when(mockRemoteDataSource.getMobileNumberAndToken(any, any))
                .thenThrow(ServerException());
            // act
            final result = await repository.getMobileNumberAndToken(tMobileNumber, tPassword);
           
            // assert
            verify(mockRemoteDataSource.getMobileNumberAndToken(tMobileNumber, tPassword));
            verifyZeroInteractions(mockLoginLocalDataScource);
            expect(result, Left(ServerFailure()));
          },
        );

        
      });

      group('device is offline', (){
        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });
        test('should return network failure when device is not connected to internet', () async{

          //arrange
          
          //act
          final result = await repository.getMobileNumberAndToken(tMobileNumber, tPassword);

          //assert
          verifyZeroInteractions(mockRemoteDataSource);
          
          expect(result, Left(NetworkFailure()));

          
        });
      });
      
  });
}