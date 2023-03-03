import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/bookings_provider.dart';
import 'package:rentbox_vendor/res/components/loading.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:rentbox_vendor/view_model/bookings/booking_detailes.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          backgroundColor: MyColors.body,
          bottom: const TabBar(
            indicatorColor: MyColors.btnText,
            dividerColor: Color.fromARGB(230, 105, 110, 110),
            labelColor: MyColors.btnText,
            tabs: [
              Tab(text: 'Upcomming'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [UpCommingBookings(), ExpairingBookings()],
        ),
      ),
    );
  }
}

class UpCommingBookings extends StatelessWidget {
  const UpCommingBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await Provider.of<BookingProvider>(context, listen: false)
          .upcomingEvents(context);
    });

    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.body,
      body: Consumer<BookingProvider>(builder: (context, value, child) {
        log(value.photos.length.toString());
        return ListView.separated(
          shrinkWrap: true,
          itemCount: value.response.isNotEmpty ? value.carId.length : 6,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: rsize.height * 0.05,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: rsize.width * 0.03,
                  left: rsize.width * 0.05,
                  right: rsize.width * 0.05),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 23, 24, 24),
                    borderRadius: BorderRadius.all(Radius.circular(
                      rsize.width * 0.03,
                    ))),
                child: value.isLoading == false
                    ? Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: rsize.height * 0.22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(rsize.width * 0.03),
                                      topRight:
                                          Radius.circular(rsize.width * 0.03)),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(value.photos[index][0]),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: rsize.width * 0.41),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: rsize.width * 0.03),
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookingDetailes(index: index),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: rsize.width * 1,
                                      child: Text(
                                        value.carName[index].toString(),
                                        style: GoogleFonts.truculenta(
                                            color: MyColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: rsize.width * 0.075),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          value.dropOffDate[index],
                                          style: GoogleFonts.truculenta(
                                              color: MyColors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: rsize.width * 0.055),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          value.dropOffTime[index].toString(),
                                          style: GoogleFonts.truculenta(
                                              color: MyColors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: rsize.width * 0.045),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                        color: MyColors.grey, thickness: 1.5),
                                    Text(
                                      value.name[index].toString(),
                                      style: GoogleFonts.truculenta(
                                        color: MyColors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: rsize.width * 0.047,
                                      ),
                                    ),
                                    SizedBox(height: rsize.width * 0.04),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ResultShimmer(resHeight: rsize),
              ),
            );
          },
        );
      }),
    );
  }
}

class ExpairingBookings extends StatelessWidget {
  const ExpairingBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await Provider.of<BookingProvider>(context, listen: false)
          .expiringEvents(context);
    });

    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.body,
      body: Consumer<BookingProvider>(builder: (context, value, child) {
        log(value.photos.length.toString());
        return ListView.separated(
          shrinkWrap: true,
          itemCount: value.response.isNotEmpty ? value.carId.length : 6,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: rsize.height * 0.05,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: rsize.width * 0.03,
                  left: rsize.width * 0.05,
                  right: rsize.width * 0.05),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 23, 24, 24),
                    borderRadius: BorderRadius.all(Radius.circular(
                      rsize.width * 0.03,
                    ))),
                child: value.isLoading == false
                    ? Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: rsize.height * 0.22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(rsize.width * 0.03),
                                      topRight:
                                          Radius.circular(rsize.width * 0.03)),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(value.photos[index][0]),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: rsize.width * 0.41),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: rsize.width * 0.03),
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookingDetailes(index: index),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: rsize.width * 1,
                                      child: Text(
                                        value.carName[index].toString(),
                                        style: GoogleFonts.truculenta(
                                            color: MyColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: rsize.width * 0.075),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          value.dropOffDate[index],
                                          style: GoogleFonts.truculenta(
                                              color: MyColors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: rsize.width * 0.055),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          value.dropOffTime[index].toString(),
                                          style: GoogleFonts.truculenta(
                                              color: MyColors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: rsize.width * 0.045),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                        color: MyColors.grey, thickness: 1.5),
                                    Text(
                                      value.name[index].toString(),
                                      style: GoogleFonts.truculenta(
                                        color: MyColors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: rsize.width * 0.047,
                                      ),
                                    ),
                                    SizedBox(height: rsize.width * 0.04),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ResultShimmer(resHeight: rsize),
              ),
            );
          },
        );
      }),
    );
  }
}
