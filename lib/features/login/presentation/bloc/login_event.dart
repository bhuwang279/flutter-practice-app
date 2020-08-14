import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {

  final String mobileNumber;
  final String password;

  LoginButtonPressed({@required this.mobileNumber, @required this.password});
  @override
 
  List<Object> get props => [mobileNumber, password];
  
}
