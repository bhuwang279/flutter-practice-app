import 'package:recharge_app/core/bloc_helpers/bloc_provider.dart';
import 'package:recharge_app/core/validators/mobile_number_validator.dart';
import 'package:recharge_app/core/validators/password_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginFormBloc extends Object
    with MobileNumberValidator, PasswordValidator
    implements BlocBase {
  //Controllers

  final BehaviorSubject<String> _mobileNumberController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  //Inputs

  Function(String) get onMobileNumberChange => _mobileNumberController.sink.add;
  Function(String) get onPasswordChange => _passwordController.sink.add;

  //Validators

  Stream<String> get mobileNumber =>
      _mobileNumberController.transform(validateMobileNumber);
  Stream<String> get password =>
      _passwordController.transform(validatePassword);

  //login button
  Stream<bool> get loginValid =>
      Observable.combineLatest2(mobileNumber, password, (m, p) => true);
  @override
  void dispose() {
    _mobileNumberController?.close();
    _passwordController?.close();
  }
}
