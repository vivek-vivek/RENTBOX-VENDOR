import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';

class AddCarProvider with ChangeNotifier {
  int? selectedRadio;
  int value = 1;
  String? categoryName;
  List imagelist = [];
  List<String> imageUrls = [];
  List<XFile> file = [];
  List allProductList = [];
  bool isLoading = false;
  String? result;

  ///
  /// Radio button for [Gear Type]
  setSelectedRadio(int val) {
    selectedRadio = val;
    notifyListeners();
  }

  ///
  /// get umage from gallery using [ImagePicker]
  Future getImage(context) async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickMultiImage();

    if (file.length > 3 || imagelist.length > 3) {
      commonSnackBar(context: context, text: 'Only 3 Images can add');

      return;
    } else if (imagelist.length + file.length > 3) {
      commonSnackBar(
          context: context,
          text: 'Only ${3 - imagelist.length} more Images can add');

      return;
    }

    imagelist.addAll(file);
    log(imagelist.toString());
    notifyListeners();
  }

  ///
  /// this will [delete] the image from yu selected
  void deleteImageList(int index) {
    imagelist.removeAt(index); // using list index
    notifyListeners();
  }
}
