import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/data/services/add_car_server.dart';
import 'package:rentbox_vendor/res/components/loading.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<AddCarProvider>(context, listen: false).loading(false);
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
          "Images",
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
      body: Padding(
        padding: EdgeInsets.all(rsize.width * 0.05),
        child: Consumer<AddCarProvider>(builder: (context, prv, child) {
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Car's Images",
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: rsize.width * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
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
                      Icons.camera_alt,
                      color: MyColors.btnText,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                height: MediaQuery.of(context).size.width / 1,
                child: prv.carimgList.isNotEmpty
                    ? GridView.builder(
                        dragStartBehavior: DragStartBehavior.down,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        itemCount: prv.carimgList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, top: 5),
                              child: Container(
                                height: rsize.width * 0.5,
                                width: rsize.width * 0.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(prv.carimgList[index].path),
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -6,
                              top: -15,
                              child: IconButton(
                                onPressed: () {
                                  prv.deletecarimgList(index);
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: MyColors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const Center(child: Text('Select your Car Images')),
              ),
              SizedBox(height: rsize.width * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Car's doquments",
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: rsize.width * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (prv.carimgList.length <= 3) {
                        log('message');
                        prv.getImageForDoqument(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Only 3 Images can add'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: MyColors.btnText,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(rsize.width * 0.02),
                  ),
                ),
                height: MediaQuery.of(context).size.width / 1,
                child: prv.doqumentimgList.isNotEmpty
                    ? GridView.builder(
                        // dragStartBehavior: DragStartBehavior.down,
                        physics: const NeverScrollableScrollPhysics(),
                        // scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        itemCount: prv.doqumentimgList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10, crossAxisCount: 2),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, top: 5),
                              child: Container(
                                height: rsize.width * 0.5,
                                width: rsize.width * 0.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(prv.doqumentimgList[index].path),
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -6,
                              top: -15,
                              child: IconButton(
                                onPressed: () {
                                  prv.deleteDoquementimgList(index);
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: MyColors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const Center(
                        child: Text('Doquements'),
                      ),
              ),
              SizedBox(height: rsize.width * 0.05),
              SizedBox(
                width: double.infinity,
                // height: ,
                child:
                    Consumer<AddCarProvider>(builder: (context, value, child) {
                  return value.isloading == true
                      ? LoadingCircle(rsize: rsize)
                      : ElevatedButton(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          onPressed: () {
                            postImages(context);
                          },
                          child: const Text(
                            'Finish',
                            style: TextStyle(color: MyColors.btnText),
                          ),
                        );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}

Future<void> postImages(context) async {
  await Provider.of<AddCarProvider>(context, listen: false).loading(true);
  log("logding");
  await Provider.of<AddCarProvider>(context, listen: false)
      .carToCloudinory(context);
  await Provider.of<AddCarProvider>(context, listen: false)
      .doqumentsToCloudinory(context);
  await AddCarServices().addNewCar(context);
  Provider.of<AddCarProvider>(context, listen: false).loading(false);
  log('not loading');
  Navigator.pushReplacementNamed(context, '/successSpalsh');
  // Navigator.of(context).pushReplacement(MaterialPageRoute(
  //   builder: (context) => const SuccessSpalsh(),
  // ));
}
