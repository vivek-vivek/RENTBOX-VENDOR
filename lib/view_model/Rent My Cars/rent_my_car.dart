// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class RentMyCar extends StatelessWidget {
  const RentMyCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> selectedValuePick = ["Wayanad", 'Malappuram', 'Kozhikode'];
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
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
      body: ListView(
        padding: EdgeInsets.only(
            left: rsize.width * 0.04, right: rsize.width * 0.04),
        children: [
          Row(
            children: [
              CommonTextformfelid(
                  rsize: rsize, hintText: "Model Name", width: 0.63),
              SizedBox(width: rsize.width * 0.03),
              DropeDownbutton(
                  rsize: rsize,
                  hint: "Seat",
                  width: 0.25,
                  height: 0.15,
                  data: selectedValuePick),
            ],
          ),
          SizedBox(height: rsize.width * 0.035),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextformfelid(
                  rsize: rsize, hintText: "RC Number", width: 0.63),
              CommonTextformfelid(rsize: rsize, hintText: "price", width: 0.26),
            ],
          ),
          SizedBox(height: rsize.width * 0.035),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropeDownbutton(
                  rsize: rsize,
                  hint: "District",
                  width: 0.44,
                  height: 0.15,
                  dHeight: rsize.width * 0.5,
                  data: selectedValuePick),
              DropeDownbutton(
                  rsize: rsize,
                  hint: 'Pickupoints',
                  height: 0.15,
                  width: 0.44,
                  data: selectedValuePick),
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
                        value: 1,
                        groupValue: prv.selectedRadio,
                        onChanged: (value) => prv.setSelectedRadio(value!)),
                    const Text("Petroll"),
                    Radio(
                        value: 2,
                        groupValue: prv.selectedRadio,
                        onChanged: (value) => prv.setSelectedRadio(value!)),
                    const Text("Desel"),
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
                        value: 2,
                        groupValue: prv.selectedRadio,
                        onChanged: (value) => prv.setSelectedRadio(value!)),
                    const Text("Auto Gear"),
                    Radio(
                        value: 1,
                        groupValue: prv.selectedRadio,
                        onChanged: (value) => prv.setSelectedRadio(value!)),
                    const Text('Manuel Gear'),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: rsize.width * 0.035),
          Consumer<AddCarProvider>(builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(rsize.width * 0.02),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  if (value.imagelist.length <= 3) {
                    value.getImage(context);
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
            );
          }),
          SizedBox(height: rsize.width * 0.035),

          /// image pickker for [car Images]
          Consumer<AddCarProvider>(
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                height: MediaQuery.of(context).size.width / 3.4,
                child: value.imagelist.isNotEmpty
                    ? GridView.builder(
                        // dragStartBehavior: DragStartBehavior.down,

                        // scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        itemCount: value.imagelist.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10, crossAxisCount: 4),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Image.file(
                              File(value.imagelist[index].path),
                            ),
                            Positioned(
                              right: 8,
                              top: -15,
                              child: IconButton(
                                onPressed: () {
                                  value.deleteImageList(index);
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

          Consumer<AddCarProvider>(builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(rsize.width * 0.02),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  if (value.imagelist.length <= 3) {
                    value.getImage(context);
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
            );
          }),
          SizedBox(height: rsize.width * 0.035),

          /// Image pickeer [car doquemnts]
          Consumer<AddCarProvider>(
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                height: MediaQuery.of(context).size.width / 3.4,
                child: value.imagelist.isNotEmpty
                    ? GridView.builder(
                        // dragStartBehavior: DragStartBehavior.down,

                        // scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        itemCount: value.imagelist.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10, crossAxisCount: 4),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Image.file(
                              File(value.imagelist[index].path),
                            ),
                            Positioned(
                              right: 8,
                              top: -15,
                              child: IconButton(
                                onPressed: () {
                                  value.deleteImageList(index);
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
        ],
      ),
    );
  }
}

String? selectedValuePick;

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
  });

  final Size rsize;
  String hint;
  final num height;
  final num width;
  final List<String> data;
  final double dHeight;
  final double dWidth;

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
          hint: Text(hint),
          style: const TextStyle(color: MyColors.black),
          value: selectedValuePick,
          items: data.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                height: dHeight,
                width: dWidth,
                child: Padding(
                    padding: EdgeInsets.only(left: rsize.width * 0.1),
                    child: Text(
                      value,
                      style: GoogleFonts.truculenta(
                        color: MyColors.black,
                        fontSize: rsize.width * 0.04,
                      ),
                    )),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Provider.of<LocationProvider>(context, listen: false)
            //     .setStartTime(newValue.toString());
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
  });

  final Size rsize;
  final String hintText;
  num height;
  num width;

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
