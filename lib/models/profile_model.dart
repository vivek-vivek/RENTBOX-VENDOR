import 'dart:convert';

class ProfileModel {
  ProfileModel({
    required this.profile,
  });

  Profile profile;

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.mobile,
    required this.profilePic,
  });

  String id;
  String name;
  int mobile;
  String profilePic;

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        name: json["name"],
        mobile: json["mobile"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "profilePic": profilePic,
      };
}

//                                                                             /
//                                                                             /
//                                                                             /
//                                                                             /
///-------------------------------Edit Profile --------------------------------/

class EditProfileWithOtp {
  EditProfileWithOtp({
    required this.name,
    required this.mobile,
    required this.otp,
  });

  String name;
  String mobile;
  String otp;

  factory EditProfileWithOtp.fromRawJson(String str) =>
      EditProfileWithOtp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditProfileWithOtp.fromJson(Map<String, dynamic> json) =>
      EditProfileWithOtp(
        name: json["name"],
        mobile: json["mobile"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "otp": otp,
      };
}

//                                                                             /
//                                                                             /
//                                                                             /
//                                                                             /
///-------------------------- otp for edit profile ----------------------------/

class SendOtpModel {
  SendOtpModel({
    required this.name,
    required this.mobile,
  });

  String name;
  String mobile;

  factory SendOtpModel.fromRawJson(String str) =>
      SendOtpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
        name: json["name"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
      };
}
