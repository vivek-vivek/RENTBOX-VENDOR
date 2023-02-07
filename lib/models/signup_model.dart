class SignupModel {
  String? name;
  String? mobile;

  String? password;

  SignupModel({this.name, this.mobile, this.password});

  SignupModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    mobile = json["mobile"];

    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["mobile"] = mobile;
    data["password"] = password;
    return data;
  }
}
