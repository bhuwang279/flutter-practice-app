import 'package:dartz/dartz.dart';
import 'package:recharge_app/core/errors/failures.dart';
import 'package:recharge_app/features/login/domain/entities/login.dart';
import 'package:recharge_app/features/login/domain/usecases/get_mobile_number_and_token.dart';
import 'package:meta/meta.dart';
import '../../../../../core/bloc_helpers/bloc_event_state.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Server Failure';

class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
      final GetMobileNumberAndToken getMobileNumberAndToken;
  AuthenticationBloc({@required this.getMobileNumberAndToken})
      : assert(getMobileNumberAndToken !=null),super(
          initialState: AuthenticationState.notAuthenticated(),
        );

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {
    if (event is AuthenticationEventLogin) {
      // Inform that we are proceeding with the authentication
      yield AuthenticationState.authenticating();

      final failureORLogin = await getMobileNumberAndToken(
            Params(mobileNumber: event.mobileNumber, password: event.password));
        yield* _eitherLoggedInOrErrorState(failureORLogin);
     
    }

    if (event is AuthenticationEventLogout) {
      yield AuthenticationState.notAuthenticated();
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

  Stream<AuthenticationState> _eitherLoggedInOrErrorState(
    Either<Failure, Login> either,
  ) async* {
    yield either.fold(
        (failure) => AuthenticationState.failure( _mapFailureToMessage(failure)),
        (login) => AuthenticationState.authenticated('Successful'));
  }
}
