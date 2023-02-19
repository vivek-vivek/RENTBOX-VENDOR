import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/my_cars.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/constant/image_name.dart';

class AllCars extends StatelessWidget {
  const AllCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
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
          "My Cars",
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
      body: Consumer<MyCarsProvider>(builder: (context, cars, child) {
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
                  child: cars.isloading == false
                      ? InkWell(
                          onDoubleTap: () {
                            cars.setIndex(index);
                            Navigator.pushNamed(context, '/singleProduct');
                          },
                          child: Row(
                            children: [
                              Container(
                                width: rsize.width * 0.5,
                                decoration: BoxDecoration(
                                  color: MyColors.btnText,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          cars.photos[index].first),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                  color: MyColors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(rsize.width * 0.04),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: rsize.width * 0.165),
                                  child: Column(
                                    children: [
                                      Text(
                                        cars.name[index],
                                        style: GoogleFonts.lato(
                                          color: MyColors.btnText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: rsize.width * 0.0588,
                                        ),
                                      ),
                                      Text(
                                        "${cars.price[index]} / day",
                                        style: GoogleFonts.lato(
                                          color: MyColors.btnText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: rsize.width * 0.04,
                                        ),
                                      ),
                                      Text(
                                        "verified : ${cars.verified[index]}",
                                        style: GoogleFonts.lato(
                                          color: MyColors.btnText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: rsize.width * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        )
                      : ShimmerWidget(rsize: rsize),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.rsize,
  });

  final Size rsize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 133, 129, 129),
      highlightColor: const Color.fromRGBO(186, 182, 182, 1),
      child: Container(
        height: rsize.height * 0.22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(rsize.width * 0.03),
              topRight: Radius.circular(rsize.width * 0.03)),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 97, 94, 94),
              Color.fromARGB(255, 155, 150, 150),
              Color.fromARGB(255, 255, 253, 253),
            ],
          ),
        ),
      ),
    );
  }
}
