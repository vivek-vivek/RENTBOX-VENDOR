// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/Exceptions/common_exceptions.dart';
import 'package:rentbox_vendor/data/provider/change_data.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpTextEditingController = TextEditingController();
    final focusNode = FocusNode();
    final formKeyForOtpVerification2 = GlobalKey<FormState>();
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.keyboard_double_arrow_left_sharp,
            color: Colors.black54,
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: MyColors.btnText,
            fontSize: rsize.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyColors.body,
        elevation: 0,
      ),
      backgroundColor: MyColors.body,
      body: Column(
        children: [
          SizedBox(height: rsize.width * 0.05),
          Padding(
            padding: EdgeInsets.only(
                top: rsize.width * 0.5, bottom: rsize.width * 0.05),
            child: Container(
              padding: EdgeInsets.only(top: rsize.width * 0.04),
              height: rsize.width * 0.28,
              width: rsize.width * 0.85,
              decoration: kBoxDecoration(resHeight: rsize.width),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  controller: otpTextEditingController,
                  defaultPinTheme: PinTheme(
                      width: 65,
                      height: 65,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        color: MyColors.black,
                      ),
                      decoration: kBoxDecoration(resHeight: rsize.width)),
                  // validator: (value) {
                  //   if (value!.length < 4) {
                  //     return 'Enter 4 digit OTP';
                  //   }
                  //   return null;
                  // },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.1),
            child: Column(
              children: [
                Container(
                  height: rsize.width * 0.15,
                  width: rsize.width * 0.75,
                  decoration: kBoxDecoration(
                      resHeight: rsize.width, color: MyColors.black),
                  child: TextButton(
                    onPressed: () async {
                      log(otpTextEditingController.text);

                      // if (formKeyForOtpVerification2.currentState!.validate()) {
                      //   internetConncetionCheck(context);
                      await Provider.of<ChangeBasicsProvider>(context,
                              listen: false)
                          .patchedProfile(
                        context: context,
                        otp: otpTextEditingController.text.toString(),
                      );
                      if (Provider.of<ChangeBasicsProvider>(context).nextPage ==
                          true) {
                        Navigator.pushReplacementNamed(
                            context, '/successSpalsh');
                      }

                      // }
                      log(otpTextEditingController.text);
                    },
                    child: Text(
                      'SUBMIT',
                      style: GoogleFonts.abrilFatface(
                          fontSize: rsize.width * 0.04, color: MyColors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
