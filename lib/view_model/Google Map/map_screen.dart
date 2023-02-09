import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> controllers = Completer();

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(11.248737, 75.83374),
    zoom: 14.4746,
  );

// on below line we have created the list of markers

// created method for getting user current product
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markersList = [];

    markersList.clear();
    // for (var i = 8; i < 12; i++) {
    //   markersList.add(
    //     Marker(
    //       // onTap: () => mapUser.setCtrlValue(
    //       //     text: product.pointNames[i],
    //       //     id: product.carId,
    //       //     obj: product.pickupPoints[i].id,
    //       //     lat: product.lat[i],
    //       //     lng: product.lng[i]),
    //       markerId: MarkerId("$i"),
    //       infoWindow: InfoWindow(title: "$i}"),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //       position: LatLng(
    //         11.258 + i,
    //         75.7804 + i,
    //       ),
    //     ),
    //   );
    // }

    // final List<Marker> markers = markersList;
    // created method for getting user current location
    Future<Position> getUserCurrentLocation() async {
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) async {
        await Geolocator.requestPermission();
      });
      return await Geolocator.getCurrentPosition();
    }

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await getLocation();
    // });
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogle,
          zoomControlsEnabled: false,
          // markers: Set<Marker>.of(markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          trafficEnabled: true,
          onMapCreated: (GoogleMapController controller) async {
            controllers.complete(controller);
            Position position = await getUserCurrentLocation();
            await controller
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14.4746,
            )));
          },
        ),
      ),
    );
  }
}
