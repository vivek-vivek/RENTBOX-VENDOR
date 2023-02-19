// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/bookings_provider.dart';
import 'package:rentbox_vendor/data/provider/change_data.dart';
import 'package:rentbox_vendor/data/provider/location_proivider.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

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
            decoration: const BoxDecoration(color: Colors.amber),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    Provider.of<ChangeBasicsProvider>(context)
                        .profileUrl
                        .toString(),
                  ),
                  radius: rsize.width * 0.075,
                ),
                Text(
                  "Vivek kuruppath",
                  style: GoogleFonts.lato(
                    color: MyColors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    fontSize: rsize.width * 0.045,
                  ),
                ),
                Text(
                  "8089246277",
                  style: GoogleFonts.lato(
                    color: MyColors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    fontSize: rsize.width * 0.04,
                  ),
                ),
              ],
            ),
          ),

          ///--------[Rent car]
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/carBasics');
                    await Provider.of<LocationProvider>(context, listen: false)
                        .getLocationResponse(context);
                  },
                  icon: const Icon(Icons.car_repair),
                  label: Text(
                    "New Car",
                    style: GoogleFonts.lato(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      fontSize: rsize.width * 0.04,
                    ),
                  ),
                )
              ],
            ),
          ),

          ///-----[Order]
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    await Provider.of<BookingProvider>(context, listen: false)
                        .upcomingEvents(context);
                    await Provider.of<BookingProvider>(context, listen: false)
                        .expiringEvents(context);
                    Navigator.pushNamed(context, '/orderDetails');
                  },
                  icon: const Icon(Icons.transcribe_sharp),
                  label: Text(
                    "Bookings",
                    style: GoogleFonts.lato(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                      fontSize: rsize.width * 0.04,
                    ),
                  ),
                )
              ],
            ),
          ),

          ///-----------[Settings]
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    Provider.of<ChangeBasicsProvider>(context, listen: false)
                        .getProfile(context: context);
                    Navigator.pushNamed(context, '/profile');
                  },
                  icon: const Icon(Icons.settings),
                  label: Text(
                    "Profile",
                    style: GoogleFonts.lato(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5,
                      fontSize: rsize.width * 0.04,
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
