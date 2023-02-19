// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/services/login_services.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:rentbox_vendor/view_model/Vendor%20Auth/sign_up.dart';

import '../../data/provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final respHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<LoginProvider>(
              builder: (context, value, child) => Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: respHeight * 0.05),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: respHeight * 0.04),
                    decoration: kBoxDecoration(
                        resHeight: respHeight, borderRadiusOf: 0.020),
                    child: Column(
                      children: [
                        SizedBox(height: respHeight * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            decoration: commonTextfeildDecoration(
                                respHeight, "Phone Number"),
                            controller: value.mobileController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            maxLength: 10,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a mobile number';
                              } else if (value.length > 10 ||
                                  value.length < 10) {
                                return 'Please enter a valid mobile number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: respHeight * 0.05),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: value.passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                            obscureText: value.passwordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              floatingLabelStyle: TextStyle(
                                fontSize: respHeight * 0.05,
                                color: MyColors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  (respHeight * 0.02),
                                ),
                              ),
                              labelStyle: GoogleFonts.anybody(
                                  color: MyColors.black,
                                  fontSize: respHeight * 0.035),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: respHeight * 0.002,
                                    color: MyColors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(respHeight * 0.02)),
                                borderSide: BorderSide(
                                    width: respHeight * 0.003,
                                    color: MyColors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(respHeight * 0.02)),
                                borderSide: BorderSide(
                                  width: respHeight * 0.003,
                                  color: MyColors.grey,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .passwordShow();
                                },
                                icon: Icon(
                                  value.passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: MyColors.black,
                                ),
                              ),
                              fillColor: Colors.grey.shade300,
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: respHeight * 0.06),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GestureDetector(
                            child: Container(
                              height: respHeight * 0.15,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                LoginApiServices().loginApiServices(
                                    context: context,
                                    password: value.passwordController.text,
                                    mobile: value.mobileController.text);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: respHeight * 0.05,
                            horizontal: respHeight * 0.06,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dont have an account ?',
                                style: TextStyle(
                                  fontSize: respHeight * 0.045,
                                  color: MyColors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  value.passwordController.clear();
                                  value.mobileController.clear();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: respHeight * 0.045,
                                    color: MyColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
