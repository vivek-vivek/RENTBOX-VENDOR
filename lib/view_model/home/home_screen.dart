import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentbox_vendor/res/constant/image_name.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.black),
        backgroundColor: MyColors.body,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: rsize.width * 0.05,
              top: rsize.width * 0.025,
            ),
            child: CircleAvatar(
              backgroundImage: const AssetImage("lib/view/user.png"),
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
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.05),
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
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.05),
            child: const Divider(color: MyColors.black),
          ),
          SizedBox(height: rsize.width * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.05),
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
                      fontSize: rsize.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: rsize.width * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.05),
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
                    onPressed: () => Navigator.pushNamed(context, '/allCars'),
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
          SizedBox(height: rsize.width * 0.05),
          ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: rsize.width * 0.10);
            },
            itemBuilder: (BuildContext context, int index) {
              return MyCars(rsize: rsize);
            },
          ),
          SizedBox(height: rsize.width * 0.1),
        ],
      ),
      drawer: const DrawerWidget(),
    );
  }
}

///
///-----------------------DRAWER OF HOME BAR---------------------------------///
///
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final rsize = MediaQuery.of(context).size;
    return Drawer(
      surfaceTintColor: MyColors.btnText,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IMG.car),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Let's rent",
                style: GoogleFonts.lato(
                  color: MyColors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 5,
                  fontSize: rsize.width * 0.075,
                ),
              ),
            ),
          ),

          ///--------[Rent car]
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/rentMyCar'),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                width: double.infinity,
                height: rsize.width * 0.1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rent my car",
                    style: GoogleFonts.lato(
                      color: MyColors.btnText,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                      fontSize: rsize.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///-----[Order]
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                width: double.infinity,
                height: rsize.width * 0.1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Orders",
                    style: GoogleFonts.lato(
                      color: MyColors.btnText,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                      fontSize: rsize.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///----[Notification]
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                width: double.infinity,
                height: rsize.width * 0.1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Orders",
                    style: GoogleFonts.lato(
                      color: MyColors.btnText,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                      fontSize: rsize.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///-----------[Settings]
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                width: double.infinity,
                height: rsize.width * 0.1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Setings",
                    style: GoogleFonts.lato(
                      color: MyColors.btnText,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                      fontSize: rsize.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
/*-------------------------------MY CARS[5]  list  -------------------------------------*/
///
class MyCars extends StatelessWidget {
  const MyCars({
    super.key,
    required this.rsize,
  });

  final Size rsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.05),
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
                      topRight: Radius.circular(rsize.width * 0.05),
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
                            fontSize: rsize.width * 0.05,
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
  }
}
