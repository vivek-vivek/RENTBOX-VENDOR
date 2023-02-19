// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/bookings_provider.dart';
import 'package:rentbox_vendor/data/provider/change_data.dart';
import 'package:rentbox_vendor/res/components/loading.dart';
import 'package:rentbox_vendor/res/components/texform_feld.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class ChangeBasics extends StatelessWidget {
  const ChangeBasics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Consumer2<ChangeBasicsProvider, BookingProvider>(
          builder: (context, value, value2, child) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.05),
          children: [
            CommonTextformfelid(
              rsize: rsize,
              hintText: 'Name',
              width: 1,
              controller: value.nameCtrl,
              // texttype: TextInputType.name,
              errormessage: "Enter Model Name",
            ),
            SizedBox(height: rsize.width * 0.01),
            CommonTextformfelid(
              rsize: rsize,
              hintText: 'Mobile Number',
              width: 1,
              controller: value.mobileCtrl,
              // texttype: TextInputType.name,
              errormessage: "Enter Model Name",
            ),
            SizedBox(height: rsize.width * 0.03),
            ElevatedButton(
              onPressed: () async {
                await value.fetchOtpData(context: context);
                if (value.nextPage == true) {
                  Navigator.pushNamed(context, '/otpScreen');
                }
              },
              child: value2.isLoading == false
                  ? const Text("Change")
                  : LoadingCircle(rsize: rsize),
            )
          ],
        );
      }),
    );
  }
}
