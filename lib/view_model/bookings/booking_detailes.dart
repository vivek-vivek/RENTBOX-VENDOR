// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/bookings_provider.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

import 'package:shimmer/shimmer.dart';

class BookingDetailes extends StatelessWidget {
  const BookingDetailes({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final rsize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.body,
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
          'Booked Vechile',
          style: TextStyle(
            color: MyColors.btnText,
            fontSize: rsize.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyColors.body,
        elevation: 0,
      ),
      body: Consumer<BookingProvider>(
        builder: (context, product, child) {
          return Padding(
            padding: EdgeInsets.all(rsize.width * 0.05),
            child: ListView(
              children: [
                CaroselImages(rsize: rsize.width, index: index),
                HeadingTexts(
                    title: product.carName[index],
                    rsize: rsize,
                    color: MyColors.btnText),
                Divider(
                  height: rsize.width * 0.05,
                  color: MyColors.grey,
                ),
                SmallTexts(
                  title: 'Date',
                  rsize: rsize,
                  color: MyColors.black,
                ),
                SizedBox(height: rsize.width * 0.02),
                Row(
                  children: [
                    CommonRoundIcon(
                        rsize: rsize, icon: Icons.calendar_month_outlined),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "     ${product.pickupDate[index].toString()}   ${product.pickupTime[index].toString()}",
                          style: GoogleFonts.truculenta(
                            color: Colors.black,
                            fontSize: rsize.width * 0.04,
                          ),
                        ),
                        Text(
                          "     ${product.dropOffDate[index].toString()}   ${product.dropOffTime[index].toString()}",
                          style: GoogleFonts.truculenta(
                            color: Colors.black,
                            fontSize: rsize.width * 0.04,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: rsize.width * 0.02),
                Divider(
                  height: rsize.width * 0.05,
                  color: MyColors.grey,
                ),
                SmallTexts(
                  title: 'PickUp & Return',
                  rsize: rsize,
                  color: MyColors.black,
                ),
                SizedBox(height: rsize.width * 0.02),
                Row(
                  children: [
                    CommonRoundIcon(
                        rsize: rsize, icon: Icons.location_on_outlined),
                    Padding(
                      padding: EdgeInsets.only(left: rsize.width * 0.04),
                      child: SizedBox(
                        width: rsize.width * 0.55,
                        child: Text(
                          "  ${product.name[index]}",
                          style: GoogleFonts.truculenta(
                            color: Colors.black,
                            fontSize: rsize.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: rsize.width * 0.02),
                Divider(height: rsize.width * 0.05, color: MyColors.grey),
                SmallTexts(
                  title: 'Security',
                  rsize: rsize,
                  color: MyColors.black,
                ),
                SizedBox(height: rsize.width * 0.02),
                Row(
                  children: [
                    CommonRoundIcon(
                        rsize: rsize, icon: Icons.health_and_safety_outlined),
                    Text(
                      "     Insurense available for the travellars",
                      style: GoogleFonts.truculenta(
                        color: Colors.black,
                        fontSize: rsize.width * 0.04,
                      ),
                    )
                  ],
                ),
                SizedBox(height: rsize.width * 0.02),
                Divider(height: rsize.width * 0.05, color: MyColors.grey),
                SizedBox(height: rsize.width * 0.02),
                Container(
                  height: rsize.width * 0.13,
                  decoration: BoxDecoration(
                    color: MyColors.grey,
                    borderRadius: BorderRadius.circular(rsize.width * 0.05),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: rsize.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount Payed ",
                          style: GoogleFonts.truculenta(
                            color: MyColors.btnText,
                            fontSize: rsize.width * 0.04,
                          ),
                        ),
                        Text(
                          "${product.price[index]}  ₹",
                          style: GoogleFonts.truculenta(
                            color: Color.fromARGB(255, 115, 236, 119),
                            fontSize: rsize.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: rsize.width * 0.02),
                Divider(height: rsize.width * 0.05, color: MyColors.grey),
                SmallTexts(
                  title: 'Car basics',
                  rsize: rsize,
                  color: MyColors.black,
                ),
                SizedBox(height: rsize.width * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CommonRoundIcon(
                          rsize: rsize,
                          icon: Icons.airline_seat_recline_extra,
                        ),
                        SmallTexts(
                          title: '${product.seatNum[index]} Seat',
                          rsize: rsize,
                          color: MyColors.black,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CommonRoundIcon(
                          rsize: rsize,
                          icon: Icons.local_gas_station_outlined,
                        ),
                        SmallTexts(
                          title: product.fuelType[index],
                          rsize: rsize,
                          color: MyColors.black,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CommonRoundIcon(
                          rsize: rsize,
                          icon: Icons.settings,
                        ),
                        SmallTexts(
                          title: '${product.gearType[index]} gear',
                          rsize: rsize,
                          color: MyColors.black,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: rsize.width * 0.02),
                SizedBox(height: rsize.width * 0.02),
                SizedBox(height: rsize.width * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }
}

// => Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => PaymentScreen(index: index),
//               )),
class CommonRoundIcon extends StatelessWidget {
  const CommonRoundIcon({
    super.key,
    required this.rsize,
    required this.icon,
    this.radius = 0.075,
  });

  final Size rsize;
  final IconData icon;
  final radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: rsize.width * radius,
      backgroundColor: MyColors.red,
      child: CircleAvatar(
        radius: rsize.width * 0.073,
        backgroundColor: MyColors.btnText,
        child: Icon(
          icon,
          color: Colors.white,
          size: rsize.width * 0.075,
        ),
      ),
    );
  }
}

class HeadingTexts extends StatelessWidget {
  const HeadingTexts({
    super.key,
    required this.title,
    required this.rsize,
    required this.color,
  });

  final String title;
  final Size rsize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.truculenta(
        color: color,
        fontSize: rsize.width * 0.06,
      ),
    );
  }
}

class SmallTexts extends StatelessWidget {
  SmallTexts(
      {super.key,
      required this.title,
      required this.rsize,
      required this.color,
      this.fontW,
      this.fontSize = 0.05});

  final String title;
  final Size rsize;
  final Color color;
  double fontSize;
  bool? fontW = false;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.truculenta(
          color: color,
          fontSize: rsize.width * fontSize,
          fontWeight: fontW == true ? FontWeight.bold : FontWeight.normal),
    );
  }
}

//Consumer<Searchprovider>(
// builder: (context, product, child) =>

class CaroselImages extends StatelessWidget {
  CaroselImages({
    super.key,
    required this.rsize,
    required this.index,
  });

  final double rsize;
  int index;
  dynamic product;

  @override
  Widget build(BuildContext context) {
    return Provider.of<BookingProvider>(context).isLoading == true
        ? const simmerWidget(width: 01, height: 0.6)
        : Consumer<BookingProvider>(builder: (context, value, child) {
            return SizedBox(
              width: rsize * 1,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: rsize * 0.50,
                    autoPlay: true,
                    animateToClosest: true,
                    viewportFraction: 1,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 2000)),
                items: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                      color: MyColors.black,
                      image: DecorationImage(
                        image: NetworkImage(
                          value.photos[index][0],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          value.photos[index][1],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          value.photos[index][2],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            );
          });
  }
}

class simmerWidget extends StatelessWidget {
  const simmerWidget({super.key, required this.width, required this.height});
  final num width;
  final num height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 133, 129, 129),
      highlightColor: const Color.fromRGBO(186, 182, 182, 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber,
        ),
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.width * height,
      ),
    );
  }
}
