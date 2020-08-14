import 'dart:async';

// Should start with 17 or 16 , should contain exactly 8 numbers [0-9]
const String _mobileNumberRegex = r"^(?=.*[17]{2}|[77]{2})(?=.*\d{8})(?=.{8}$)";
class MobileNumberValidator {
  final StreamTransformer<String,String> validateMobileNumber = StreamTransformer<String,String>.fromHandlers(handleData: (mobileNumber, sink){
    final RegExp mobileNumberExp =
        new RegExp(_mobileNumberRegex);

    if (!mobileNumberExp.hasMatch(mobileNumber)){
      sink.addError('Enter a valid mobile number');
    } else {
      sink.add(mobileNumber);
    }
  });
}