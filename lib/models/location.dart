// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

class LocationModel {
  LocationModel({
    required this.locations,
  });

  List<Location> locations;

  factory LocationModel.fromRawJson(String str) =>
      LocationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    required this.id,
    required this.location,
    required this.image,
    required this.pickupPoints,
  });

  String id;
  String location;
  String image;
  List<PickupPoint> pickupPoints;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"],
        location: json["location"],
        image: json["image"],
        pickupPoints: List<PickupPoint>.from(
            json["pickupPoints"].map((x) => PickupPoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "location": location,
        "image": image,
        "pickupPoints": List<dynamic>.from(pickupPoints.map((x) => x.toJson())),
      };
}

class PickupPoint {
  PickupPoint({
    required this.coords,
    required this.name,
    required this.id,
  });

  Coords coords;
  String name;
  String id;

  factory PickupPoint.fromRawJson(String str) =>
      PickupPoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PickupPoint.fromJson(Map<String, dynamic> json) => PickupPoint(
        coords: Coords.fromJson(json["coords"]),
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "coords": coords.toJson(),
        "name": name,
        "_id": id,
      };
}

class Coords {
  Coords({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Coords.fromRawJson(String str) => Coords.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
