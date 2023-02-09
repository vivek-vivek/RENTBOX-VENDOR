import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:rentbox_vendor/res/constant/image_name.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class ProductLandingScreen extends StatelessWidget {
  const ProductLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> data = [0];
    final rsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.body,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.keyboard_double_arrow_left_sharp),
        ),
        title: Text(
          "My cars",
          style: TextStyle(
            color: Colors.black54,
            fontSize: rsize.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyColors.body,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: rsize.width * 0.025),
        height: rsize.height * 1,
        width: rsize.width * 1,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return data.isNotEmpty
                ? GridTile(
                    footer: Container(
                      height: rsize.width * 0.075,
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        border: Border.all(
                          color: MyColors.grey,
                          width: rsize.width * 0.0025,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(rsize.width * 0.03),
                            bottomRight: Radius.circular(rsize.width * 0.03)),
                      ),
                      child: Center(
                        child: Text(
                          "Audi RS&",
                          style: TextStyle(
                            color: MyColors.btnText,
                            fontSize: rsize.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, '/singleProduct'),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(IMG.car), fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(rsize.width * 0.05),
                            bottomRight: Radius.circular(rsize.width * 0.04),
                          ),
                        ),
                      ),
                    ),
                  )
                : MySimmer(rsize: rsize);
          },
        ),
      ),
    );
  }
}

/*------------------------------SHIMMER WIDGET--------------------------------*/
class MySimmer extends StatelessWidget {
  const MySimmer({
    super.key,
    required this.rsize,
  });

  final Size rsize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 133, 129, 129),
      highlightColor: const Color.fromRGBO(186, 182, 182, 1),
      child: GridTile(
        footer: Container(
          height: rsize.width * 0.35,
          decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.grey,
              width: rsize.width * 0.005,
            ),
            color: Colors.black,
            borderRadius: BorderRadius.circular(rsize.width * 0.03),
          ),
          child: const Center(),
        ),
        child: const SizedBox(),
      ),
    );
  }
}
