import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/data/provider/location_proivider.dart';
import 'package:rentbox_vendor/res/components/loading.dart';
import 'package:rentbox_vendor/res/components/texform_feld.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class CarBasics extends StatelessWidget {
  const CarBasics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            pro.seatNumctrl.clear();
            pro.gearctrl.clear();
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
        builder: (context, carpro, locpro, child) => carpro.isloading == true
            ? LoadingCircle(rsize: rsize)
            : Padding(
                padding: EdgeInsets.only(
                  left: rsize.width * 0.05,
                  right: rsize.width * 0.05,
                ),
                child: Form(
                  key: carpro.carBasicsKey,
                  child: ListView(
                    children: [
                      // Model Name
                      CommonTextformfelid(
                        rsize: rsize,
                        hintText: 'Model Name',
                        width: 1,
                        controller: carpro.modelnamectrl,
                        // texttype: TextInputType.name,
                        errormessage: "Enter Model Name",
                      ),

                      //Rc Number
                      CommonTextformfelid(
                        rsize: rsize,
                        hintText: 'RC Number',
                        width: 1,
                        controller: carpro.rcNumctrl,
                        // texttype: const TextInputType.numberWithOptions(
                        //     decimal: true),
                        errormessage: "Enter Rc Number",
                      ),

                      // Number Seat
                      CommonTextformfelid(
                        rsize: rsize,
                        hintText: 'Number Of seat',
                        width: 1,
                        controller: carpro.seatNumctrl,
                        // texttype: const TextInputType.numberWithOptions(
                        //     decimal: true),
                        errormessage: "Enter number of seat",
                        seat: true,
                      ),

                      // Price / day
                      CommonTextformfelid(
                        rsize: rsize,
                        hintText: 'Rent / Day',
                        width: 1,
                        controller: carpro.pricectrl,
                        // texttype: const TextInputType.numberWithOptions(
                        //     decimal: true),
                        errormessage: "Enter Price",
                      ),

                      SizedBox(height: rsize.width * 0.05),

                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(rsize.width * 0.02),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Radio(
                                    value: 'auto',
                                    groupValue:
                                        carpro.selecteGeardRadio ?? 'auto',
                                    onChanged: (value) =>
                                        carpro.setgearRadio(value)),
                                const Text("Auto Gear"),
                                Radio(
                                    value: 'manual',
                                    groupValue:
                                        carpro.selecteGeardRadio ?? 'auto',
                                    onChanged: (value) =>
                                        carpro.setgearRadio(value)),
                                const Text('Manuel Gear    '),
                              ],
                            ),
                            SizedBox(height: rsize.width * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Radio(
                                    value: 'petrol',
                                    groupValue: carpro.selecteOildRadio,
                                    onChanged: (value) =>
                                        carpro.setoilRadio(value)),
                                const Text("Petrol"),
                                Radio(
                                    value: 'diesel',
                                    groupValue: carpro.selecteOildRadio,
                                    onChanged: (value) =>
                                        carpro.setgearRadio(value)),
                                const Text("  Diesel"),
                                SizedBox(width: rsize.width * 0.005),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: rsize.width * 0.05),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          onPressed: () {
                            if (carpro.carBasicsKey.currentState!.validate()) {
                              carpro.setSeatNum(carpro.seatNumctrl.text);
                              carpro.setGear(carpro.gearctrl.text);
                              Navigator.pushNamed(context, '/addCarLocation');
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
              ),
      ),
    );
  }
}
