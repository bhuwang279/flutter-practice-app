import 'package:recharge_app/features/login/domain/entities/login.dart';
import 'package:meta/meta.dart';

class LoginModel extends Login {
  LoginModel({@required mobileNumber, @required token}) :super(mobileNumber: mobileNumber , token: token);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['tokenCreate']['token'],
      mobileNumber: json['tokenCreate']['user']['email'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobileNumber':mobileNumber,
      'token': token,
    };
  }
}