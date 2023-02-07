import 'dart:convert';

class LoginModel {
  LoginModel({
    required this.message,
    required this.accessToken,
    required this.user,
    required this.userType,
  });

  String message;
  String accessToken;
  User user;
  String userType;

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        accessToken: json["accessToken"],
        user: User.fromJson(json["user"]),
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "user": user.toJson(),
        "userType": userType,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.mobile,
    required this.verified,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  int mobile;
  bool verified;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        mobile: json["mobile"],
        verified: json["verified"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "verified": verified,
        "password": password,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
