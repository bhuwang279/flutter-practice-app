import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Login extends Equatable {
  final String mobileNumber;
  final String token;

  Login({@required this.mobileNumber, @required this.token});

  @override
  List<Object> get props => [mobileNumber, token];
}