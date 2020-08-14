import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:recharge_app/core/constants.dart';
import 'package:recharge_app/core/errors/failures.dart';
import 'package:recharge_app/core/utils/validators.dart';
import 'package:recharge_app/features/login/domain/entities/login.dart';
import 'package:recharge_app/features/login/domain/usecases/get_mobile_number_and_token.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Server Failure';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetMobileNumberAndToken getMobileNumberAndToken;
  final Validator validator;

  LoginBloc({@required this.getMobileNumberAndToken, @required this.validator})
      : assert(getMobileNumberAndToken != null),
        assert(validator != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      final validateEither = validator.validateMobileNumberAndPassword(
          event.mobileNumber,
          MOBILE_NUMBER_LENGTH,
          event.password,
          MINIMUM_PASSWORD_LENGTH);

      yield* validateEither.fold((failure) async* {
        yield LoginFailure(error: failure.toString());
      }, (boolean) async* {
        yield LoginLoading();
        final failureORLogin = await getMobileNumberAndToken(
            Params(mobileNumber: event.mobileNumber, password: event.password));
        yield* _eitherLoggedInOrErrorState(failureORLogin);
        
      });
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

  Stream<LoginState> _eitherLoggedInOrErrorState(
    Either<Failure, Login> either,
  ) async* {
    yield either.fold(
        (failure) => LoginFailure(error: _mapFailureToMessage(failure)),
        (login) => LoggedIn(login: login));
  }
}
