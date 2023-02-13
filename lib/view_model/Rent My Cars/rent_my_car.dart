// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/data/provider/location_proivider.dart';
import 'package:rentbox_vendor/data/services/add_car_server.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:rentbox_vendor/view_model/home/home_screen.dart';

class RentMyCar extends StatelessWidget {
  const RentMyCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List empty = ['Select data'];
    List<String> selectedprvPick = ["Wayanad", 'Malappuram', 'Kozhikode'];
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            final pro = Provider.of<AddCarProvider>(context, listen: false);
            pro.cloudinoryCarURL.clear();
            pro.cloudinoryDoquementURL.clear();
            pro.carFile.clear();
            pro.carimgList.clear();
            pro.cloudinoryDoquementURL.clear();
            pro.doqumentFile.clear();
            pro.doqumentimgList.clear();
            pro.rcNumctrl.clear();
            pro.modelnamectrl.clear();

            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.keyboard_double_arrow_left_sharp,
            color: Colors.black54,
          ),
        ),
        title: Text(
          "Add car",
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
      body: Consumer2<AddCarProvider, LocationProvider>(
        builder: (context, prv, locationProv, child) {
          return prv.isloading == true
              ? LoadingCircle(rsize: rsize)
              : ListView(
                  padding: EdgeInsets.only(
                      left: rsize.width * 0.04,
                      right: rsize.width * 0.04,
                      bottom: rsize.width * 0.04),
                  children: [
                    Row(
                      children: [
                        CommonTextformfelid(
                            controller: prv.modelnamectrl,
                            rsize: rsize,
                            hintText: "Model Name",
                            width: 0.63),
                        SizedBox(width: rsize.width * 0.03),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius:
                                BorderRadius.circular(rsize.width * 0.03),
                          ),
                          height: rsize.width * 0.15,
                          width: rsize.width * 0.25,
                          child: Center(
                            child: DropdownButton<String>(
                              style: const TextStyle(color: MyColors.black),
                              value: prv.seatNumctrl.text.isEmpty
                                  ? prv.seat[0]
                                  : prv.seatNumctrl.text,
                              items: prv.seat.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: rsize.width * 0.1),
                                        child: Text(
                                          value.toString(),
                                          style: GoogleFonts.truculenta(
                                            color: MyColors.black,
                                            fontSize: rsize.width * 0.04,
                                          ),
                                        )),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                log(value!);
                                Provider.of<AddCarProvider>(context,
                                        listen: false)
                                    .setSeatNum(value);
                              },
                              dropdownColor: MyColors.white,
                              borderRadius:
                                  BorderRadius.circular(rsize.width * 0.03),
                              underline: const SizedBox(),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: rsize.width * 0.035),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextformfelid(
                            controller: prv.rcNumctrl,
                            rsize: rsize,
                            hintText: "RC Number",
                            width: 0.63),
                        CommonTextformfelid(
                            controller: prv.pricectrl,
                            rsize: rsize,
                            hintText: "price",
                            width: 0.26),
                      ],
                    ),
                    SizedBox(height: rsize.width * 0.035),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius:
                                BorderRadius.circular(rsize.width * 0.03),
                          ),
                          height: rsize.width * 0.15,
                          width: rsize.width * 0.44,
                          child: Center(
                            child: DropdownButton<String>(
                              style: const TextStyle(color: MyColors.black),
                              value: prv.districctrl.text.isEmpty
                                  ? selectedprvPick[0]
                                  : prv.districctrl.text,
                              items: (locationProv.locationNames.isEmpty
                                      ? empty
                                      : locationProv.locationNames)
                                  .map((dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: rsize.width * 0.1),
                                        child: Text(
                                          value.toString(),
                                          style: GoogleFonts.truculenta(
                                            color: MyColors.black,
                                            fontSize: rsize.width * 0.04,
                                          ),
                                        )),
                                  ),
                                );
                              }).toList(),

                              /// [ONCAHNEGE FUNCTION]
                              onChanged: (String? value) => Provider.of<
                                      AddCarProvider>(context, listen: false)
                                  .setDistrict(context: context, value: value),
                              dropdownColor: MyColors.white,
                              borderRadius:
                                  BorderRadius.circular(rsize.width * 0.03),
                              underline: const SizedBox(),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ),

                        ///  [Pickup]

                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius:
                                BorderRadius.circular(rsize.width * 0.03),
                          ),
                          height: rsize.width * 0.15,
                          width: rsize.width * 0.44,
                          child: Center(
                            child: DropdownButton<String>(
                              hint: const Center(child: Text("Manadhavadi")),
                              // value: prv.pickupctrl.text,
                              items: locationProv.dropdownItems,
                              onChanged: (value) {
                                log(value.toString());
                                prv.setPickup(context: context, value: value);
                              },
                              dropdownColor: MyColors.white,
                              borderRadius:
                                  BorderRadius.circular(rsize.width * 0.03),
                              underline: const SizedBox(),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: rsize.width * 0.035),
                    Consumer<AddCarProvider>(
                      builder: (context, prv, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(rsize.width * 0.02),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Radio(
                                  value: 'petrol',
                                  groupValue: prv.selecteOildRadio,
                                  onChanged: (value) => prv.setoilRadio(value)),
                              const Text("Petrol"),
                              Radio(
                                  value: 'diesel',
                                  groupValue: prv.selecteOildRadio,
                                  onChanged: (value) => prv.setoilRadio(value)),
                              const Text("Diesel"),
                              SizedBox(width: rsize.width * 0.005),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: rsize.width * 0.035),
                    Consumer<AddCarProvider>(
                      builder: (context, prv, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(rsize.width * 0.02),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Radio(
                                  value: 'auto',
                                  groupValue: prv.selecteGeardRadio,
                                  onChanged: (value) =>
                                      prv.setgearRadio(value)),
                              const Text("Auto Gear"),
                              Radio(
                                  value: 'manual',
                                  groupValue: prv.selecteGeardRadio,
                                  onChanged: (value) =>
                                      prv.setgearRadio(value)),
                              const Text('Manuel Gear'),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: rsize.width * 0.035),
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(rsize.width * 0.02),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (prv.carimgList.length <= 3) {
                            prv.getImageForCar(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Only 3 Images can add'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: MyColors.btnText,
                        ),
                      ),
                    ),
                    SizedBox(height: rsize.width * 0.035),

                    /// image pickker for [car Images]
                    Consumer<AddCarProvider>(
                      builder: (context, prv, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(rsize.width * 0.02),
                            ),
                          ),
                          height: MediaQuery.of(context).size.width / 3.4,
                          child: prv.carimgList.isNotEmpty
                              ? GridView.builder(
                                  // dragStartBehavior: DragStartBehavior.down,

                                  // scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  itemCount: prv.carimgList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 4,
                                  ),
                                  itemBuilder: (context, index) => Stack(
                                    children: [
                                      Image.file(
                                        File(prv.carimgList[index].path),
                                      ),
                                      Positioned(
                                        right: 8,
                                        top: -15,
                                        child: IconButton(
                                          onPressed: () {
                                            prv.deletecarimgList(index);
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const Center(
                                  child: Text('Select your Car Images'),
                                ),
                        );
                      },
                    ),
                    SizedBox(height: rsize.width * 0.035),

                    Consumer<AddCarProvider>(builder: (context, prv, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(rsize.width * 0.02),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (prv.carimgList.length <= 3) {
                              prv.getImageForDoqument(context);
                            } else {
                              commonSnackBar(
                                  text: "Only 3 Images can add",
                                  context: context);
                            }
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: MyColors.btnText,
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: rsize.width * 0.035),

                    /// Image pickeer [car doquemnts]
                    Consumer<AddCarProvider>(
                      builder: (context, prv, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(rsize.width * 0.02),
                            ),
                          ),
                          height: MediaQuery.of(context).size.width / 3.4,
                          child: prv.doqumentimgList.isNotEmpty
                              ? GridView.builder(
                                  // dragStartBehavior: DragStartBehavior.down,

                                  // scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  itemCount: prv.doqumentimgList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) => Stack(
                                    children: [
                                      Image.file(
                                        File(prv.doqumentimgList[index].path),
                                      ),
                                      Positioned(
                                        right: 8,
                                        top: -15,
                                        child: IconButton(
                                          onPressed: () {
                                            prv.deleteDoquementimgList(index);
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const Center(
                                  child: Text('Doquements'),
                                ),
                        );
                      },
                    ),
                    SizedBox(height: rsize.width * 0.035),
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(rsize.width * 0.02),
                        ),
                      ),
                      child: TextButton(
                          onPressed: () => postImages(context),
                          child: const Center(child: Text("Upload"))),
                    )
                  ],
                );
        },
      ),
    );
  }
}

//  if (_formKey.currentState!.validate())
Future<void> postImages(context) async {
  Provider.of<AddCarProvider>(context, listen: false).loading(true);
  await Provider.of<AddCarProvider>(context, listen: false)
      .carToCloudinory(context);
  await Provider.of<AddCarProvider>(context, listen: false)
      .doqumentsToCloudinory(context);
  await AddCarServices().addNewCar(context);
  await Provider.of<AddCarProvider>(context, listen: false).loading(false);
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => const HomeScreen(),
  ));
}

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({
    super.key,
    required this.rsize,
  });

  final Size rsize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: rsize.height * 0.11,
            width: rsize.width * 0.25,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('lib/view/mr-bean-waiting.gif'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(
                Radius.circular(rsize.width * 0.5),
              ),
            ),
          ),
          SizedBox(
            height: rsize.height * 0.11,
            width: rsize.width * 0.25,
            child: CircularProgressIndicator(
              strokeWidth: rsize.width * 0.01,
            ),
          ),
        ],
      ),
    );
  }
}

String? selectedprvPick;

void name() {}

class DropeDownbutton extends StatelessWidget {
  DropeDownbutton({
    super.key,
    required this.rsize,
    required this.hint,
    this.height = 0.11,
    required this.width,
    required this.data,
    this.dHeight = 0,
    this.dWidth = 0,
    this.functions,
  });

  final Size rsize;
  String hint;
  final num height;
  final num width;
  final List<String> data;
  final double dHeight;
  final double dWidth;
  Function? functions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(rsize.width * 0.03),
      ),
      height: rsize.width * height,
      width: rsize.width * width,
      child: Center(
        child: DropdownButton<String>(
          style: const TextStyle(color: MyColors.black),
          value: selectedprvPick,
          items: data.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                child: Padding(
                    padding: EdgeInsets.only(left: rsize.width * 0.1),
                    child: Text(
                      value.toString(),
                      style: GoogleFonts.truculenta(
                        color: MyColors.black,
                        fontSize: rsize.width * 0.04,
                      ),
                    )),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            functions!();
            // Provider.of<LocationProvider>(context, listen: false)
            //     .setStartTime(newprv.toString());
          },
          dropdownColor: MyColors.white,
          borderRadius: BorderRadius.circular(rsize.width * 0.03),
          underline: const SizedBox(),
          alignment: Alignment.topLeft,
        ),
      ),
    );
  }
}

class CommonTextformfelid extends StatelessWidget {
  CommonTextformfelid({
    super.key,
    required this.rsize,
    required this.hintText,
    this.height = 0.15,
    required this.width,
    required this.controller,
  });

  final Size rsize;
  final String hintText;
  num height;
  num width;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(rsize.width * 0.02),
        ),
      ),
      width: rsize.width * width,
      height: rsize.width * height,
      child: Padding(
        padding: EdgeInsets.all(rsize.width * 0.04),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration.collapsed(
              border: InputBorder.none, hintText: hintText),
        ),
      ),
    );
  }
}

/*
                  style: GoogleFonts.lato(
                  color: MyColors.btnText,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 5,
                  fontSize: rsize.width * 0.05),  
*/
