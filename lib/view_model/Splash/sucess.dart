// ignore: must_be_immutable
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:rentbox_vendor/view_model/home/home_screen.dart';

class SuccessSpalsh extends StatefulWidget {
  const SuccessSpalsh({super.key});

  @override
  State<SuccessSpalsh> createState() => _SuccessSpalshState();
}

class _SuccessSpalshState extends State<SuccessSpalsh> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log('+-----------------------------WOW------------------------------+');
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColors.body,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: rsize.width * 0.5,
                width: rsize.width * 0.5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                    image: AssetImage("lib/view/successgif.gif"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
