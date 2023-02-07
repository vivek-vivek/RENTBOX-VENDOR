import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Controller Variables
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();
  final conformPasswordController = TextEditingController();

  /// boolvalue variables
  bool passwordVisible = true;

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  /// InitState .
  /// The functon that we want to exicute at the begining
  /// of the page loads .
  void initState() {
    passwordVisible = false;
    notifyListeners();
  }

  /// Password Show Icon Function
  /// Used in - SighnUp Screen
  /// This function will helpe to handle the password show button .
  /// It return true or false .
  void passwordShow() {
    passwordVisible = !passwordVisible;
    // Ui refreshin
    notifyListeners();
  }

  nameValidation(value) {
    final RegExp nameRegExp = RegExp('[a-zA-Z]');
    if (value.isEmpty) {
      return 'Enter Your Name';
    }
    if (!nameRegExp.hasMatch(value)) {
      return 'Enter a Valid Name';
    }
    return null;
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
}
