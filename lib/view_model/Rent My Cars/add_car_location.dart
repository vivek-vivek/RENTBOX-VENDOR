import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/data/provider/location_proivider.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class AddCarLocation extends StatelessWidget {
  const AddCarLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> carData = GlobalKey<FormState>();
    List empty = ['pickup'];
    List<String> selectedprvPick = ["Wayanad", 'Malappuram', 'Kozhikode'];
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<AddCarProvider>(context, listen: false)
                .districctrl
                .clear();
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.keyboard_double_arrow_left_sharp,
            color: Colors.black54,
          ),
        ),
        title: Text(
          "Location",
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
          builder: (context, carpro, locpro, _) {
        return Padding(
          padding: EdgeInsets.all(rsize.width * 0.05),
          child: Form(
            key: carData,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: rsize.width * 0.2,
                      child: TextFormField(
                        controller: carpro.districctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please  Select location";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(rsize.width * 0.02),
                        ),
                      ),
                      child: DropdownButton<String>(
                        style: const TextStyle(color: MyColors.black),
                        value: carpro.districctrl.text.isEmpty
                            ? selectedprvPick[0]
                            : carpro.districctrl.text,
                        items: (selectedprvPick.isEmpty
                                ? empty
                                : locpro.locationNames)
                            .map((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(left: rsize.width * 0.1),
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
                        onChanged: (String? value) {
                          log(value.toString());
                          Provider.of<AddCarProvider>(context, listen: false)
                              .setDistrict(context: context, value: value);
                        },
                        dropdownColor: MyColors.white,
                        borderRadius: BorderRadius.circular(rsize.width * 0.03),
                        underline: const SizedBox(),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: rsize.width * 0.05),

                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: rsize.width * 0.2,
                      child: TextFormField(
                        controller: carpro.districctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please  Select location";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(rsize.width * 0.02),
                        ),
                      ),
                      child: DropdownButton<String>(
                        hint: const Center(child: Text("Manadhavadi")),
                        value: carpro.pickupId.isEmpty
                            ? empty[0]
                            : carpro.pickupId,
                        items: locpro.dropdownItems,
                        onChanged: (value) {
                          log(value.toString());
                          carpro.setPickup(context: context, value: value);
                        },
                        dropdownColor: MyColors.white,
                        borderRadius: BorderRadius.circular(rsize.width * 0.03),
                        underline: const SizedBox(),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  // height: ,
                  child: ElevatedButton(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: () {
                      if (carData.currentState!.validate()) {
                        Provider.of<AddCarProvider>(context, listen: false)
                            .loading(false);
                        Navigator.pushNamed(context, '/addImage');
                      }
                    },
                    child: const Text(
                      'Contine',
                      style: TextStyle(color: MyColors.btnText),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
