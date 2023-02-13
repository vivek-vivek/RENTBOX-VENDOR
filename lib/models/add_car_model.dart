import 'dart:convert';

class AddCarOrderModel {
  AddCarOrderModel({
    required this.carData,
    required this.photos,
    required this.documents,
  });

  CarData carData;
  List<String> photos;
  List<String> documents;

  factory AddCarOrderModel.fromRawJson(String str) =>
      AddCarOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCarOrderModel.fromJson(Map<String, dynamic> json) =>
      AddCarOrderModel(
        carData: CarData.fromJson(json["carData"]),
        photos: List<String>.from(json["photos"].map((x) => x)),
        documents: List<String>.from(json["documents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "carData": carData.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "documents": List<dynamic>.from(documents.map((x) => x)),
      };
}

class CarData {
  CarData({
    required this.modelName,
    required this.price,
    required this.seatNum,
    required this.location,
    required this.rcNumber,
    required this.pickupPoints,
    required this.fuelType,
    required this.transmission,
  });

  String modelName;
  int price;
  int seatNum;
  String location;
  int rcNumber;
  List<String> pickupPoints;
  String fuelType;
  String transmission;

  factory CarData.fromRawJson(String str) => CarData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarData.fromJson(Map<String, dynamic> json) => CarData(
        modelName: json["modelName"],
        price: json["price"],
        seatNum: json["seatNum"],
        location: json["location"],
        rcNumber: json["rcNumber"],
        pickupPoints: List<String>.from(json["pickupPoints"].map((x) => x)),
        fuelType: json["fuelType"],
        transmission: json["transmission"],
      );

  Map<String, dynamic> toJson() => {
        "modelName": modelName,
        "price": price,
        "seatNum": seatNum,
        "location": location,
        "rcNumber": rcNumber,
        "pickupPoints": List<dynamic>.from(pickupPoints.map((x) => x)),
        "fuelType": fuelType,
        "transmission": transmission,
      };
}
