  
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:recharge_app/features/login/domain/entities/login.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoggedIn extends LoginState{
  final Login login;

  LoggedIn({@required this.login});

  @override
  List<Object> get props  => [login];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}