import 'package:flutter/material.dart';
import 'package:recharge_app/core/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends BlocEvent {
 

  AuthenticationEvent();
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String mobileNumber;
  final String password;
  AuthenticationEventLogin({@required this.mobileNumber, @required this.password});
}

class AuthenticationEventLogout extends AuthenticationEvent {}
