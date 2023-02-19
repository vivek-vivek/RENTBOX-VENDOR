import 'dart:convert';

class MyCarsModel {
  MyCarsModel({
    required this.cars,
  });

  List<Car> cars;

  factory MyCarsModel.fromRawJson(String str) =>
      MyCarsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyCarsModel.fromJson(Map<String, dynamic> json) => MyCarsModel(
        cars: List<Car>.from(json["cars"].map((x) => Car.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cars": List<dynamic>.from(cars.map((x) => x.toJson())),
      };
}

class Car {
  Car({
    required this.id,
    required this.seatNum,
    required this.location,
    required this.name,
    required this.price,
    required this.rcNumber,
    required this.verified,
    required this.photos,
  });

  String id;
  int seatNum;
  Location location;
  String name;
  int price;
  int rcNumber;
  String verified;
  List<String> photos;

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["_id"],
        seatNum: json["seatNum"],
        location: Location.fromJson(json["location"]),
        name: json["name"],
        price: json["price"],
        rcNumber: json["rcNumber"],
        verified: json["verified"],
        photos: List<String>.from(json["photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "seatNum": seatNum,
        "location": location.toJson(),
        "name": name,
        "price": price,
        "rcNumber": rcNumber,
        "verified": verified,
        "photos": List<dynamic>.from(photos.map((x) => x)),
      };
}

class Location {
  Location({
    required this.id,
    required this.location,
  });

  String id;
  String location;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "location": location,
      };
}
