import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({
    super.key,
    required this.rsize,
  });

  final Size rsize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: rsize.width * 0.01,
      ),
    );
  }
}

class ResultShimmer extends StatelessWidget {
  const ResultShimmer({
    super.key,
    required this.resHeight,
  });

  final Size resHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 133, 129, 129),
          highlightColor: const Color.fromRGBO(186, 182, 182, 1),
          child: Container(
            height: resHeight.height * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(resHeight.width * 0.03),
                  topRight: Radius.circular(resHeight.width * 0.03)),
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
        ),
        SizedBox(height: resHeight.width * 0.05, width: resHeight.width * 0.4),
        Padding(
          padding: EdgeInsets.only(top: resHeight.width * 0.41),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: resHeight.width * 1,
                height: resHeight.width * 0.075,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: const Color.fromARGB(255, 80, 78, 78),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                  height: resHeight.width * 0.04, width: resHeight.width * 0.4),
              SizedBox(
                height: resHeight.width * 0.055,
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 177, 174, 174),
                  highlightColor: const Color.fromARGB(255, 148, 138, 138),
                  child: Container(
                    color: const Color.fromARGB(255, 190, 188, 188),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 226, 224, 224),
            highlightColor: const Color.fromARGB(255, 177, 175, 175),
            child: Icon(
              Icons.favorite,
              size: resHeight.width * 0.1,
            ),
          ),
        ),
      ],
    );
  }
}
