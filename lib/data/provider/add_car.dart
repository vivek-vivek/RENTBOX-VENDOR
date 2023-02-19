import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/location_proivider.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';

class AddCarProvider with ChangeNotifier {
  // Radio Button Variables
  String? selecteOildRadio;
  String? selecteGeardRadio;

// Image picker variables
  List carimgList = [];
  List doqumentimgList = [];

  List<String> imageUrls = [];
  List<XFile> carFile = [];
  List<XFile> doqumentFile = [];

  // cloudinory  Variables
  List<String> cloudinoryCarURL = [];
  List<String> cloudinoryDoquementURL = [];

  /// Loding variable
  bool isloading = false;
  List<String> seat = ['2', '4', '6'];
  int intseatNum = 0;

  String? districId;
  String pickupId = '';
  List<String> passPickupId = [];
  TextEditingController modelnamectrl = TextEditingController();
  TextEditingController seatNumctrl = TextEditingController();
  TextEditingController rcNumctrl = TextEditingController();
  TextEditingController pricectrl = TextEditingController();
  TextEditingController districctrl = TextEditingController();
  TextEditingController pickupctrl = TextEditingController();
  TextEditingController oilctrl = TextEditingController();
  TextEditingController gearctrl = TextEditingController();

  /// Globel Keys
  GlobalKey<FormState> carBasicsKey = GlobalKey<FormState>();

  ///-------------------------------[   FUNCTIONS  ]------------------------------
  /// Radio button for [Gear Type]
  setoilRadio(val) {
    oilctrl.text = val.toString();
    selecteOildRadio = val;
    log(val.toString());
    notifyListeners();
  }

  setgearRadio(val) {
    gearctrl.text = val.toString();
    selecteGeardRadio = val;
    log(gearctrl.text);
    notifyListeners();
  }

  loading(boolv) {
    isloading = boolv;
    notifyListeners();
  }

  setSeatNum(val) {
    seatNumctrl.text = val;
    intseatNum = int.parse(val);
    log(intseatNum.toString());
    notifyListeners();
  }

  setDistrict({context, value}) async {
    final pro2 = Provider.of<LocationProvider>(context, listen: false);
    districctrl.text = value;
    int i = pro2.locationNames.indexOf(value);
    districId = pro2.locationID[i];
    log("${districctrl.text} : $districId");
    notifyListeners();
  }

  setPickup({value, context}) async {
    passPickupId.clear();
    final pro2 = Provider.of<LocationProvider>(context, listen: false);
    pickupId = value;
    int i = pro2.id.indexOf(value);
    pickupctrl.text = pro2.pickupName[i].toString();
    passPickupId.add(pickupId);
    log("${pickupctrl.text} : $pickupId");
    notifyListeners();
  }

  setPickupId(val) {
    pickupId = val;
    notifyListeners();
  }

  setOilType(val) {
    oilctrl.text = val;
    notifyListeners();
  }

  setGear(val) {
    gearctrl.text = val;
    selecteGeardRadio = val;
  }

  // check requerid data
  formValidation() {}

/*-------------------------------GET IMAGE FROM GALLERY------------------------*/
  ///
  /// GET [CAR IMAGE] from gallery using [ImagePicker]
  Future getImageForCar(context) async {
    ImagePicker imagePicker = ImagePicker();
    carFile = await imagePicker.pickMultiImage();

    if (carFile.length > 3 || carimgList.length > 3) {
      commonSnackBar(context: context, text: 'Only 3 Images can add');

      return;
    } else if (carimgList.length + carFile.length > 3) {
      commonSnackBar(
          context: context,
          text: 'Only ${3 - carimgList.length} more Images can add');

      return;
    }

    carimgList.addAll(carFile);
    notifyListeners();
  }

  /// GET [DOQUEMENT IMAGE] from gallery using [ImagePicker]
  Future getImageForDoqument(context) async {
    ImagePicker imagePicker = ImagePicker();
    notifyListeners();
    doqumentFile = await imagePicker.pickMultiImage();
    notifyListeners();

    if (doqumentFile.length > 3 || doqumentimgList.length > 3) {
      commonSnackBar(context: context, text: 'Only 3 Images can add');

      return;
    } else if (doqumentimgList.length + doqumentFile.length > 3) {
      commonSnackBar(
          context: context,
          text: 'Only ${3 - doqumentimgList.length} more Images can add');

      return;
    }

    doqumentimgList.addAll(doqumentFile);
    notifyListeners();
  }

  /// this will [ delete ] the [ CAR ]image from yu selected
  void deletecarimgList(int index) {
    carimgList.removeAt(index); // using list index
    notifyListeners();
  }

  void deleteDoquementimgList(int index) {
    doqumentimgList.removeAt(index); // using list index
    notifyListeners();
  }

/*------------------------- CLOUDINORY IMAGE UPLOAD --------------------------*/
  /// upload [car] images to [firbase storage]
  Future<void> carToCloudinory(context) async {
    Provider.of<AddCarProvider>(context, listen: false).loading(true);
    cloudinoryCarURL.clear();
    notifyListeners();
    // This three params from  [Cloudinary] .
    final cloudinary = Cloudinary.signedConfig(
      apiKey: CloudinoryApi.KEY,
      apiSecret: CloudinoryApi.SECRET,
      cloudName: CloudinoryApi.NAME,
    );
    log('Post car images into cloudinory  serverr...');

    for (var image in carFile) {
      final response = await cloudinary.upload(
          file: image.path,
          resourceType: CloudinaryResourceType.image,
          folder: "Doquement",
          fileName: image.name);

      if (response.isSuccessful) {
        // log(response.statusCode.toString());
        cloudinoryCarURL.add(response.secureUrl.toString());
        notifyListeners();
        log('For car visit -->  ${response.secureUrl}  ----> * SUCCESS * ');
      } else {
        commonSnackBar(text: "Failed to upload images", context: context);
      }

      notifyListeners();
    }
    carFile.clear();
    carimgList.clear();
    Provider.of<AddCarProvider>(context, listen: false).loading(false);
    notifyListeners();
  }

  Future<void> doqumentsToCloudinory(context) async {
    Provider.of<AddCarProvider>(context, listen: false).loading(true);
    cloudinoryDoquementURL.clear();
    notifyListeners();
    // This three params from  [Cloudinary] .
    final cloudinary = Cloudinary.signedConfig(
      apiKey: CloudinoryApi.KEY,
      apiSecret: CloudinoryApi.SECRET,
      cloudName: CloudinoryApi.NAME,
    );
    log('Post doquments images into cloudinory  serverr...');

    for (var image in doqumentFile) {
      final response = await cloudinary.upload(
          file: image.path,
          resourceType: CloudinaryResourceType.image,
          folder: "Doquement",
          fileName: image.name);

      if (response.isSuccessful) {
        cloudinoryDoquementURL.add(response.secureUrl.toString());
        notifyListeners();
        log('For doquement visit -->  ${response.secureUrl}  ----> * SUCCESS * ');
      } else {
        commonSnackBar(text: "Failed to upload images", context: context);
      }

      notifyListeners();
    }
    doqumentFile.clear();
    doqumentimgList.clear();
    Provider.of<AddCarProvider>(context, listen: false).loading(false);
    notifyListeners();
  }
}
