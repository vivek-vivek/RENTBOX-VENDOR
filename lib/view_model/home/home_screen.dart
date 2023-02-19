import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/change_data.dart';
import 'package:rentbox_vendor/data/provider/my_cars.dart';
import 'package:rentbox_vendor/data/services/my_cars.dart';
import 'package:rentbox_vendor/res/constant/image_name.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:rentbox_vendor/view_model/home/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final rsize = MediaQuery.of(context).size;
    log(Provider.of<ChangeBasicsProvider>(context).profileUrl.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.black),
        backgroundColor: MyColors.body,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: rsize.width * 0.04,
              top: rsize.width * 0.025,
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                Provider.of<ChangeBasicsProvider>(context)
                    .profileUrl
                    .toString(),
              ),
              radius: rsize.width * 0.075,
            ),
          )
        ],
      ),
      backgroundColor: MyColors.body,
      body: ListView(
        children: [
          SizedBox(height: rsize.width * 0.075),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.04),
            child: Text(
              "Let's provide best Cars",
              style: GoogleFonts.truculenta(
                color: MyColors.black,
                fontWeight: FontWeight.w700,
                letterSpacing: 10,
                fontSize: rsize.width * 0.1,
              ),
            ),
          ),
          SizedBox(height: rsize.width * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.04),
            child: const Divider(color: MyColors.black),
          ),
          SizedBox(height: rsize.width * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.04),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                width: double.infinity,
                height: rsize.width * 0.15,
                child: Center(
                  child: Text(
                    "Let's rent",
                    style: GoogleFonts.lato(
                      color: MyColors.btnText,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                      fontSize: rsize.width * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: rsize.width * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "my cars",
                  style: GoogleFonts.lato(
                    color: MyColors.btnText,
                    fontWeight: FontWeight.w600,
                    fontSize: rsize.width * 0.065,
                  ),
                ),
                SizedBox(
                  /// navigating to [product landing page]
                  height: rsize.width * 0.075,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.btnText,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          rsize.width * 0.03,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      Provider.of<MyCarsProvider>(context, listen: false)
                          .getMyCars(context: context);

                      Navigator.pushNamed(context, '/allCars');
                    },
                    child: Text(
                      "More",
                      style: GoogleFonts.lato(
                        color: MyColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: rsize.width * 0.035,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: rsize.width * 0.04),

          ///[MYCARS]
          MyCars(rsize: rsize),

          ///
          SizedBox(height: rsize.width * 0.1),
        ],
      ),
      drawer: const DrawerWidget(),
    );
  }
}

///
///--------------------------- [MY CARS[ list] --------------------------------/
///

class MyCars extends StatelessWidget {
  const MyCars({
    super.key,
    required this.rsize,
  });

  final Size rsize;

  @override
  Widget build(BuildContext context) {
    log(context.toString());

    return Consumer<MyCarsProvider>(builder: (context, cars, child) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: cars.id.isEmpty ? 4 : cars.id.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: rsize.width * 0.10);
        },
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.04),
            child: SizedBox(
              height: rsize.width * 0.5,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(-0.5, -0.5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: rsize.width * 0.5,
                      decoration: const BoxDecoration(
                        color: MyColors.btnText,
                        image: DecorationImage(
                            image: AssetImage(IMG.car), fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(rsize.width * 0.04),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: rsize.width * 0.175),
                          child: Column(
                            children: [
                              Text(
                                'Audi RS7',
                                style: GoogleFonts.lato(
                                  color: MyColors.btnText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: rsize.width * 0.065,
                                ),
                              ),
                              Text(
                                "1500 / day",
                                style: GoogleFonts.lato(
                                  color: MyColors.btnText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: rsize.width * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
