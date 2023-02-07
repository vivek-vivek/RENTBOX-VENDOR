import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = true;

  /// boolvalue variables
  bool passwordVisible = true;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  /// Password Show Icon Function
  /// Used in - SighnUp Screen
  /// This function will helpe to handle the password show button .
  /// It return true or false .
  void passwordShow() {
    passwordVisible = !passwordVisible;
    // Ui refreshin
    notifyListeners();
  }

  phoneNumberValidation(value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }

    return null;
  }

  passwordValidation(String value) {
    // final RegExp regex =
    //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (value.length < 8) {
        return 'Enter atleast 8 digit';
      } else {
        return null;
      }
    }
  }

  loading(bool situation) {
    isLoading = situation;
    notifyListeners();
  }
}
