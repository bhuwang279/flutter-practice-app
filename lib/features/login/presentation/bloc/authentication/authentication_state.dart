import 'package:meta/meta.dart';
import 'package:recharge_app/core/bloc_helpers/bloc_event_state.dart';

class AuthenticationState extends BlocState {
  AuthenticationState({
    @required this.isAuthenticated,
    this.isAuthenticating: false,
    this.hasFailed: false,
    this.error: '',
  });

  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;

  final String error;

  factory AuthenticationState.notAuthenticated() {
    return AuthenticationState(
      isAuthenticated: false,
    );
  }

  factory AuthenticationState.authenticated(String error) {
    return AuthenticationState(
      isAuthenticated: true,
      error: error,
    );
  }

  factory AuthenticationState.authenticating() {
    return AuthenticationState(
      isAuthenticated: false,
      isAuthenticating: true,
    );
  }

  factory AuthenticationState.failure(String error) {
    return AuthenticationState(
      isAuthenticated: false,
      hasFailed: true,
      error: error
    );
  }
}
