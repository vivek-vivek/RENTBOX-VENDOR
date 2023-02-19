import 'dart:developer';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentbox_vendor/data/services/change_data_services.dart';
import 'package:rentbox_vendor/models/profile_model.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/bookings_provider.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeBasicsProvider with ChangeNotifier {
  String mobile = 'enter Mobile Number';
  String name = 'enter Name';
  bool nextPage = false;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController dummyMobile = TextEditingController();
  TextEditingController dummyName = TextEditingController();

  List<ProfileModel> response = [];
  List<Profile> profile = [];
  List<SendOtpModel> otpResponse = [];

  pageTransaction(val) {
    nextPage = true;
    notifyListeners();
  }

  setProf(String str) {
    profileUrl = str;
    notifyListeners();
  }

  String? huh;
  Future<void> getProfile({required context}) async {
    Provider.of<BookingProvider>(context, listen: false).loading(true);

    response.clear();
    nameCtrl.clear();
    mobileCtrl.clear();

    response = await ProfileServices().getProfile(context: context);
    for (var element in response) {
      profile.add(element.profile);
      notifyListeners();
    }
    for (var element in profile) {
      mobileCtrl.text = element.mobile.toString();
      nameCtrl.text = element.name;
      name = nameCtrl.text;
      mobile = mobileCtrl.text;
      huh = element.profilePic;
      profileUrl = element.profilePic;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('Profile', element.profilePic.toString());

      notifyListeners();
    }
    final prefs = await SharedPreferences.getInstance();
    profileUrl = prefs.getString('Profile');
    Provider.of<BookingProvider>(context, listen: false).loading(false);
    notifyListeners();
  }

  Future fetchOtpData({required context}) async {
    final prov2 = Provider.of<BookingProvider>(context, listen: false);
    final prov = Provider.of<ChangeBasicsProvider>(context, listen: false);
    prov2.loading(true);
    prov.pageTransaction(false);
    otpResponse.clear();
    otpResponse = await ProfileServices().sendOtpForEdit(context: context);
    for (var element in otpResponse) {
      log("dummyMobile ${dummyMobile.text}  \ndummyName${dummyName.text}");
      dummyMobile.text = element.mobile;
      dummyName.text = element.name;
      notifyListeners();
    }
    prov2.loading(false);
    prov.pageTransaction(true);
    notifyListeners();
  }

// patchProfile

  List<EditProfileWithOtp> resp = [];
  Future patchedProfile({required context, required String otp}) async {
    final prov2 = Provider.of<BookingProvider>(context, listen: false);
    prov2.loading(true);
    pageTransaction(false);
    otpResponse.clear();
    resp.clear();
    notifyListeners();
    resp = await ProfileServices().patchProfile(context: context, otp: otp);

    for (var element in otpResponse) {
      mobileCtrl.text = element.mobile;
      nameCtrl.text = element.name;
      log(" patch \ndummyMobile  ${dummyMobile.text}  \ndummyName${dummyName.text}");
      notifyListeners();
    }
    prov2.loading(false);
    pageTransaction(true);
    notifyListeners();
  }

  XFile? profileImage;
  Future getProfilePic({context}) async {
    ImagePicker imagePicker = ImagePicker();
    notifyListeners();
    profileImage = await imagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  File? image;
  String? profileUrl;
  Future<void> pickImage({required context}) async {
    final prov2 = Provider.of<BookingProvider>(context, listen: false);
    prov2.loading(true);
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      log(pickedFile.path);
      image = File(pickedFile.path);
      // This three params from  [Cloudinary] .
      final cloudinary = Cloudinary.signedConfig(
        apiKey: CloudinoryApi.KEY,
        apiSecret: CloudinoryApi.SECRET,
        cloudName: CloudinoryApi.NAME,
      );
      final response = await cloudinary.upload(
          file: image!.path,
          resourceType: CloudinaryResourceType.image,
          folder: "Profile",
          fileName: image!.path);

      if (response.isSuccessful) {
        await ProfileServices()
            .UploadProfilePic(url: response.secureUrl, context: context);
        // SHARED PRIFERENCE OBJECT
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('Profile', response.secureUrl.toString());
        profileUrl = prefs.getString('Profile');
        log('For car visit -->  ${response.secureUrl}  ----> * SUCCESS * ');
        prov2.loading(false);
      } else {
        commonSnackBar(text: "Failed to upload images", context: context);
      }

      notifyListeners();
    }
  }
}
