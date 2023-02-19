import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/bookings_provider.dart';
import 'package:rentbox_vendor/data/provider/change_data.dart';
import 'package:rentbox_vendor/models/mycars.dart';
import 'package:rentbox_vendor/res/components/loading.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
        builder: (context, value, book, child) {
          return book.isLoading == false
              ? Padding(
                  padding: EdgeInsets.only(
                      left: rsize.width * 0.055, right: rsize.width * 0.055),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: rsize.width * 0.045),
                        child: Stack(
                          children: [
                            Container(
                              height: rsize.width * 0.4,
                              width: rsize.width * 0.4,
                              decoration: BoxDecoration(
                                image: value.huh != null
                                    ? DecorationImage(
                                        image:
                                            NetworkImage(value.huh.toString()),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                borderRadius:
                                    BorderRadius.circular(rsize.width * 0.5),
                              ),
                            ),
                            Positioned(
                              top: rsize.width * 0.29,
                              left: rsize.width * 0.22,
                              child: CircleAvatar(
                                backgroundColor: MyColors.btnText,
                                child: IconButton(
                                  onPressed: () =>
                                      value.pickImage(context: context),
                                  icon: Icon(
                                    Icons.edit,
                                    color: MyColors.white,
                                    size: rsize.width * 0.08,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: rsize.width * 0.05),
                      Container(
                        padding: EdgeInsets.only(
                            top: rsize.width * 0.05, left: rsize.width * 0.05),
                        width: double.infinity,
                        height: rsize.width * 0.4,
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(rsize.width * 0.02),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: rsize.width * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 4,
                                      fontSize: rsize.width * 0.03,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/changeBasics');
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              value.name,
                              style: GoogleFonts.lato(
                                color: Colors.indigo,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 5,
                                fontSize: rsize.width * 0.05,
                              ),
                            ),
                            SizedBox(height: rsize.width * 0.05),
                            Text(
                              "Phone Number",
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 4,
                                fontSize: rsize.width * 0.03,
                              ),
                            ),
                            Text(
                              value.mobile,
                              style: GoogleFonts.lato(
                                color: Colors.indigo,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 5,
                                fontSize: rsize.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: rsize.width * 0.05),
                      // Container(
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: MyColors.white,
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(rsize.width * 0.02),
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       TextButton.icon(
                      //         onPressed: () {},
                      //         icon: const Icon(Icons.lock),
                      //         label: Text(
                      //           'Change Password',
                      //           style: GoogleFonts.lato(
                      //             color: Colors.indigo,
                      //             fontWeight: FontWeight.w700,
                      //             letterSpacing: 2,
                      //             fontSize: rsize.width * 0.04,
                      //           ),
                      //         ),
                      //       ),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: const Icon(Icons.edit, color: Colors.amber),
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                )
              : LoadingCircle(rsize: rsize);
        },
      ),
    );
  }
}
